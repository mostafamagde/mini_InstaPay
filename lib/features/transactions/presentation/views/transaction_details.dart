import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/enums/transaction_status_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/widgets/custom_button.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_user_model.dart';
import 'package:mini_instapay/features/transactions/presentation/manger/cubit/transaction_cubit.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  Widget showButton(TransactionModel transaction, context) {
    if (UserModel.instance.role != Role.admin && UserModel.instance.id == transaction.sender.id && transaction.status == TransactionStatus.success) {
      return CustomButton(
        onTap: () {
          BlocProvider.of<TransactionCubit>(context).requestRefund(transaction.id);
        },
        label: "Request Refund",
        color: Colors.red.shade700,
      );
    } else if (UserModel.instance.role == Role.admin && transaction.status == TransactionStatus.success) {
      return CustomButton(
        onTap: () {
          BlocProvider.of<TransactionCubit>(context).markAsSuspicious(transaction.id);
        },
        label: "Mark as Suspecious",
        color: Colors.red.shade700,
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    TransactionModel transaction = ModalRoute.of(context)?.settings.arguments as TransactionModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Transaction Details',
          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        leading: Transform.translate(
          offset: const Offset(12, 0.0),
          child: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9.r),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 2.0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              width: 40.0.w,
              height: 40.0.w,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14.r,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<TransactionCubit, TransactionState>(listener: (context, state) {
        if (state is ManageTransactSuccess) {
          transaction.status = state.transactionStatus;
          snackBar(content: state.massage, context: context, color: Colors.green);
        } else if (state is ManageTransactFailed) {
          snackBar(content: state.error, context: context);
        }
      }, builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ManageTransactionLoading,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusBadge(transaction.status),
                const SizedBox(height: 16.0),
                Text(
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 24.0),
                _buildUserDetail('Sender', transaction.sender),
                const SizedBox(height: 16.0),
                _buildUserDetail('Receiver', transaction.receiver),
                const SizedBox(height: 16.0),
                _buildDetailRow(
                  'Created At',
                  '${transaction.createdAt.toLocal()}'.split(' ')[0],
                ),
                SizedBox(
                  height: 32,
                ),
                showButton(transaction, context)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatusBadge(TransactionStatus status) {
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

    return Chip(
      label: Text(
        status.value,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: color,
    );
  }

  Widget _buildUserDetail(String label, TransactionUserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          '${user.firstName} ${user.lastName}',
          style: TextStyle(fontSize: 16.sp),
        ),
        Text(
          user.email,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
