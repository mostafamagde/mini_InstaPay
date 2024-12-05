import 'package:flutter/material.dart';
import 'package:untitled2/features/account_managment/data/bank_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BanksListItem extends StatelessWidget {

  final BankModel bank;
  const BanksListItem({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return InkWell(
      onTap: () {
        
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: media.width * .85,
          height: media.height * .085,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 1),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Image.network(
                    bank.logo,
                    height: 40.h,
                    width: 60.h,
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank.name,
                        style: theme.textTheme.bodyMedium,
                      ),

                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
