import 'package:flutter/material.dart';

class BanksListItem extends StatelessWidget {
  const BanksListItem({super.key});

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
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/banktest.jpg",
                    height: 50,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "National Bank of Egypt",
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
