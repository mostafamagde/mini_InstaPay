import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/account_managment/data/repository/bank_repo_impl.dart';
import 'package:untitled2/features/account_managment/presentation/banks_cubit/banks_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/widgets/bank_list_view.dart';
import 'package:untitled2/features/account_managment/presentation/widgets/logo_container.dart';

import '../../../core/utils/validation.dart';
import '../../../core/widgets/custom_text_field.dart';

class AddAccountView extends StatelessWidget {
  const AddAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider<BanksCubit>(
      create: (context) => BanksCubit(bankRepository: BankRepoImpl())..fetchBanks(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              LogoContainer(),
              Text(
                "Select Your Bank",
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 25),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Your Mobile Number 01143865112 must be",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                "registered at your bank",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          CustomTextField(
                            icon: Icons.search,
                            valid: Validation.validateRegularTextField,
                            inputType: TextInputType.text,
                            label: 'Search for specific bank name',
                          ),
                          BankListView(),
                          SizedBox(height: 32,)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
