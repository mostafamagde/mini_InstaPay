import 'package:flutter/material.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/utils/validation.dart';
import 'package:mini_instapay/core/widgets/custom_text_field.dart';
import 'package:mini_instapay/features/account_management/presentation/views/widgets/bank_list_view.dart';
import 'package:mini_instapay/features/account_management/presentation/views/widgets/logo_container.dart';

class ChooseAccountView extends StatefulWidget {
  const ChooseAccountView({super.key});

  @override
  State<ChooseAccountView> createState() => _ChooseAccountViewState();
}

class _ChooseAccountViewState extends State<ChooseAccountView> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LogoContainer(),
            Text(
              "Select Your Bank",
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 25),
            ),
            SizedBox(height: 15),
            Text(
              "Your Mobile Number ${UserModel.instance.mobileNumber} must be",
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
            ),
            Text(
              "registered at your bank",
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
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
                        BankListView(search: search),
                        SizedBox(height: 32)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
