import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/widgets/notification_icon.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:untitled2/features/transactions/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/transactions/presentation/views/widgets/transaction_card.dart';

class AllTransactionView extends StatelessWidget {
  const AllTransactionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    print(UserModel.getInstance().token);
    final user =UserModel.getInstance();
        if(user.role=="Admin")
       { BlocProvider.of<NotificationsCubit>(context).getNotification();}
    getTransactions(){
      user.role=="Admin"?BlocProvider.of<TransactionCubit>(context).getAllTransaction(): BlocProvider.of<TransactionCubit>(context).getUserTransaction();
    }
   getTransactions();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: user.role=="Admin"? SizedBox():
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
            actions: [
              user.role=="Admin"? NotificationIcon():SizedBox()
            ],
      ),
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if(state is ManageTransactSuccess){
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
