import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/features/account_managment/data/models/bank_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BanksListItem extends StatelessWidget {
  const BanksListItem({super.key, required this.bank});

  final BankModel bank;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(
          context,
          RoutesNames.addBankAccount,
          arguments: bank,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 1),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  CachedNetworkImage(
                    imageUrl: bank.logo,
                    height: 40.h,
                    width: 60.h,
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Constants.secondaryOrangeColor,
                    ),
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: Constants.secondaryOrangeColor,
                    )),
                  ),
                  SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank.name,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
