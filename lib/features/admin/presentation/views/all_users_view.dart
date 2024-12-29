import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/features/admin/presentation/views/widgets/user_item.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/core/utils/validation.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/core/widgets/custom_text_field.dart';
import 'package:mini_instapay/features/admin/presentation/manager/ban_users_cubit/ban_users_cubit.dart';
import 'package:mini_instapay/features/admin/presentation/manager/get_users_cubit/admin_get_users_cubit.dart';

class AllUsersView extends StatelessWidget {
  AllUsersView({super.key});

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? id;
    final ThemeData theme = Theme.of(context);

    return BlocConsumer<BanUsersCubit, BanUsersState>(
      listener: (context, state) {
        if (state is BanUsersSuccess) {
          snackBar(content: state.mssg, context: context, color: Colors.green);
          id = state.user.id;
        }
        if (state is BanUsersFailure) {
          snackBar(content: state.error, context: context, color: Colors.red);
        }
      },
      builder: (context, state) {
        final BanUsersCubit banCubit = BanUsersCubit.get(context);

        return ModalProgressHUD(
          inAsyncCall: state is BanUsersLoading,
          child: BlocBuilder<AdminGetUsersCubit, AdminGetUsersState>(
            builder: (context, state) {
              final AdminGetUsersCubit cubit = AdminGetUsersCubit.get(context);

              if (state is AdminGetUsersSuccess) {
                if (id != null) {
                  final index = state.users.indexWhere((v) => v.id == id);
                  state.users[index].status = "Suspended";
                  id = null;
                }
              }

              return CustomScrollView(
                slivers: [
                  // Header
                  SliverToBoxAdapter(
                    child: Container(
                      color: Constants.secondaryOrangeColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "All Users",
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: CustomTextField(
                        label: "Search Users",
                        icon: CupertinoIcons.search,
                        inputType: TextInputType.text,
                        controller: search,
                        valid: Validation.validateRegularTextField,
                        function: (value) async => await cubit.getAllUsers(value),
                      ),
                    ),
                  ),

                  if (state is AdminGetUsersFailure)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Error: ${state.errorMessage}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  // Loading State
                  if (state is AdminGetUsersLoading)
                    SliverToBoxAdapter(
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  // Success State
                  if (state is AdminGetUsersSuccess)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.users.length,
                        (context, index) {
                          return UserItem(
                            onPressed: banCubit.banUser,
                            users: state.users[index],
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
