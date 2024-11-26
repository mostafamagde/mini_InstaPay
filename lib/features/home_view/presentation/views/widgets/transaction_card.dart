import 'package:flutter/material.dart';

import '../../../../../core/utils/Constants.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return    Container(

      height: 105,
      width: media.width,
      decoration: BoxDecoration(
        border: Border(
          bottom:
          BorderSide(color: Colors.grey, width: .5),
        ),
        color: Constants.backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "123 EGP",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Container(
                height: 20,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.lightBlueAccent),
                child: Center(
                  child: Text(
                    "Successful",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(

                        color: Constants.buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.call_made_outlined,
                      color: theme.secondaryHeaderColor,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Received Money",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 10),
                  )
                ],
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mostafa Magdy Ahmed",style: theme.textTheme.bodySmall,),
                  Text(
                    "mostafamagde227@instaPay",
                    style: theme.textTheme.bodyMedium,
                  ), Text(
                    "20 Nov 2024 03:53 PM",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              )


            ],
          )
        ],
      ),
    );
  }
}
