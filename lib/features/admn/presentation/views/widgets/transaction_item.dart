import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/utils/Constants.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserModel.getInstance();

    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return Padding(

      padding:  EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        startActionPane:
        ActionPane(motion: const DrawerMotion(), extentRatio: .2, children: [
          SlidableAction(
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            onPressed: (BuildContext context) {},
          ),

        ]),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 105,
          width: media.width * .9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: .5,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "{transaction.amount} EGP",
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
                        "  transaction.status",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: 50,
                        child: FittedBox(
                          child: Text(
                            "isReceiver? Received Money Sent Money",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "isReceiver?transaction.sender.firstName:transaction.receiver.userName",
                          style: theme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          " isReceiver?transaction.sender.email:transaction.receiver.email",
                          style: theme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          "{transaction.createdAt}",
                          style: theme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
