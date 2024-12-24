import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionModel transaction;
  Color getColor(String status) {
    Color color;

    switch (status) {
      case Constants.kSuccessString:
        color = Colors.green;
        break;
      case Constants.kFailedString:
        color = Colors.red;
        break;
      case Constants.kPendingString:
        color = Colors.orange;
        break;
      case Constants.kSuspiciousString:
        color = Colors.amber;
        break;
      case Constants.kRefundingString:
        color = Colors.blue;
        break;
      case Constants.kRefundedString:
        color = Colors.teal;
        break;
      default:
        color = Colors.grey;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    final bool isReceiver = transaction.receiver.id == UserModel.instance.id;
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.transactionDetails, arguments: transaction);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
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
                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Container(
                  height: 20.h,
                  width: 75.w,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: getColor(transaction.status)),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        transaction.status,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15)
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 49.r,
                      width: 49.r,
                      decoration: BoxDecoration(color: Constants.buttonBackgroundColor, borderRadius: BorderRadius.circular(15.r)),
                      child: Icon(
                        isReceiver ? Icons.call_received_rounded : Icons.call_made_outlined,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    SizedBox(
                      width: 49.r,
                      child: FittedBox(
                        child: Text(
                          isReceiver ? "Received Money" : "Sent Money",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
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
                        "${transaction.createdAt.toLocal()}",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
