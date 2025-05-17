import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_instapay/core/enums/transaction_status_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import '../../../../../core/utils/Constants.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionModel transaction;

  Color getColor(TransactionStatus status) {
    Color color;

    switch (status) {
      case TransactionStatus.success:
        color = Colors.green;
        break;
      case TransactionStatus.failed:
        color = Colors.red;
        break;
      case TransactionStatus.pending:
        color = Colors.orange;
        break;
      case TransactionStatus.suspicious:
        color = Colors.amber;
        break;
      case TransactionStatus.refunding:
        color = Colors.blue;
        break;
      case TransactionStatus.refunded:
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
    final ThemeData theme = Theme.of(context);
    final Size media = MediaQuery.of(context).size;

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
                        transaction.status.value,
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
