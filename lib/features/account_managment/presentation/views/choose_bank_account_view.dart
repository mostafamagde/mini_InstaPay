import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_list_proxy.dart';

import 'package:untitled2/features/account_managment/presentation/views/widgets/bank_list_view.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/logo_container.dart';

import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/custom_text_field.dart';

import '../../data/repos/bank_repo_impl.dart';
import '../manager/get_all_banks/banks_cubit.dart';

class ChooseAccountView extends StatefulWidget {
  const ChooseAccountView({super.key});

  @override
  State<ChooseAccountView> createState() => _ChooseAccountViewState();

}

class _ChooseAccountViewState extends State<ChooseAccountView> {
   String search="";
  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    return BlocProvider<BanksCubit>(
      create: (context) =>
          BanksCubit(bankProxy:BankListProxy())..fetchBanks(),
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
                "Your Mobile Number ${UserModel.getInstance().mobileNumber} must be",
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
                            function: (p0) {
                              search = p0;
                              setState(() {

                              });
                            },
                            icon: Icons.search,
                            valid: Validation.validateRegularTextField,
                            inputType: TextInputType.text,
                            label: 'Search for specific bank name',
                          ),
                          BankListView(search: search,),
                          SizedBox(
                            height: 32,
                          )
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
