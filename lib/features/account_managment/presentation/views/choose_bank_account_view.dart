import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/account_managment/data/repos/all_banks_repo_impl.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_list_proxy.dart';
import 'package:untitled2/features/account_managment/presentation/manager/get_all_banks/banks_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/bank_list_view.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/logo_container.dart';

class ChooseAccountView extends StatefulWidget {
  const ChooseAccountView({super.key});

  @override
  State<ChooseAccountView> createState() => _ChooseAccountViewState();
}

class _ChooseAccountViewState extends State<ChooseAccountView> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider<BanksCubit>(
      create: (context) => BanksCubit(bankProxy: BankListProxy(ServiceLocator.getIt<SharedPreferences>(), AllBanksRepoImpl()))..fetchBanks(),
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
                "Your Mobile Number ${UserModel.instance.mobileNumber} must be",
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                "registered at your bank",
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
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
                              setState(() {});
                            },
                            icon: Icons.search,
                            valid: Validation.validateRegularTextField,
                            inputType: TextInputType.text,
                            label: 'Search for specific bank name',
                          ),
                          BankListView(
                            search: search,
                          ),
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
