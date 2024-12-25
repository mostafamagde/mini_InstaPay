import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/admn/presentation/manager/ban_users_cubit/ban_users_cubit.dart';
import 'package:untitled2/features/admn/presentation/manager/get_users_cubit/admin_get_users_cubit.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_account_list_view.dart';

class AllUsersView extends StatelessWidget {
  AllUsersView({super.key});

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? id;
    final Size media = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocConsumer<BanUsersCubit, BanUsersState>(
          listener: (context, state) {
            if (state is BanUsersSuccess) {
              snackBar(content: state.mssg, context: context, color: Colors.green);
              id = state.id;
            }
            if (state is BanUsersFailure) {
              snackBar(content: state.error, context: context, color: Colors.red);
            }
          },
          builder: (context, state) {
            final BanUsersCubit banCubit = BanUsersCubit.get(context);
            return Expanded(
              child: ModalProgressHUD(
                inAsyncCall: state is BanUsersLoading,
                child: BlocBuilder<AdminGetUsersCubit, AdminGetUsersState>(
                  builder: (context, state) {
                    if (state is AdminGetUsersSuccess) {
                      if (id != null) {
                        final index = state.users.indexWhere((v) => v.id == id);
                        state.users[index].status = "Suspended";
                        id = null;
                      }
                    }
                    final AdminGetUsersCubit cubit = AdminGetUsersCubit.get(context);

                    return CustomScrollView(
                      slivers: [
                        // Header
                        SliverToBoxAdapter(
                          child: Container(
                            width: media.width,
                            height: media.height * .08,
                            color: Constants.secondaryOrangeColor,
                            child: Padding(
                              padding: EdgeInsets.only(top: media.height * .03),
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
                              (context, index) {
                                return UserAccountListView(
                                  onPressed: banCubit.banUser,
                                  users: state.users.sublist(index, index + 1),
                                );
                              },
                              childCount: state.users.length,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
