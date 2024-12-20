import 'package:flutter/material.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionModel transaction;
        Color getColor(String status) {
          Color color ;

        switch (status) {
            case Constants.kSuccessString:
                color =Colors.green;
                break;
            case Constants.kFailedString:
                color =Colors.red;
                break;
            case Constants.kPendingString:
                color =Colors.orange;
                break;
            default:
                color =Colors.grey;
        }

        return color;
    }
  @override
  Widget build(BuildContext context) {
    final user = UserModel.getInstance();
    final bool isReceiver = transaction.receiver.id == user.id;
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 105,
      width: media.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: .5),
        ),
        color: Constants.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${transaction.amount} EGP",
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Container(
                height: 20,
                width: 75,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: getColor(transaction.status)),
                child: Center(
                  child: Text(
                    transaction.status,
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
                    decoration: BoxDecoration(color: Constants.buttonBackgroundColor, borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      isReceiver ? Icons.call_received_rounded : Icons.call_made_outlined,
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
                        isReceiver ? "Received Money" : "Sent Money",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 10),
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
                      isReceiver ? transaction.sender.firstName : transaction.receiver.userName,
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      isReceiver ? transaction.sender.email : transaction.receiver.email,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      "${transaction.createdAt}",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}