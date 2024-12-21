import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_account_list_view.dart';

import '../manager/admin_get_users_cubit.dart';

class AllUsersView extends StatelessWidget {
  AllUsersView({super.key});

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<AdminGetUsersCubit, AdminGetUsersState>(
          builder: (context, state) {
            var cubit = AdminGetUsersCubit.get(context);

            return Expanded(
              child: CustomScrollView(
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
                            users: state.users.sublist(index, index + 1),
                          );
                        },
                        childCount: state.users.length,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
