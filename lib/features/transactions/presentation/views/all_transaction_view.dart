import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/widgets/notification_icon.dart';
import 'package:mini_instapay/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:mini_instapay/features/transactions/presentation/manger/cubit/transaction_cubit.dart';
import 'package:mini_instapay/features/transactions/presentation/views/widgets/transaction_card.dart';

class AllTransactionView extends StatelessWidget {
  const AllTransactionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(UserModel.instance.token);
    if (UserModel.instance.role == Role.Admin) {
      BlocProvider.of<NotificationsCubit>(context).getNotification();
    }
    getTransactions() {
      UserModel.instance.role == Role.Admin ? BlocProvider.of<TransactionCubit>(context).getAllTransaction() : BlocProvider.of<TransactionCubit>(context).getUserTransaction();
    }

    getTransactions();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: UserModel.instance.role == Role.Admin
            ? SizedBox()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
        actions: [UserModel.instance.role == Role.Admin ? NotificationIcon() : SizedBox()],
      ),
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is ManageTransactSuccess) {
            getTransactions();
          }
        },
        builder: (context, state) {
          if (state is TransactionSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.separated(
                itemBuilder: (context, index) => TransactionCard(transaction: state.transactions[index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
                itemCount: state.transactions.length,
              ),
            );
          } else if (state is TransactionError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
