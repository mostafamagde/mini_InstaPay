import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/home_view/data/model/transaction_model.dart';
import 'package:untitled2/features/home_view/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_card.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionCubit>(context).getTransaction();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
        
        },
        builder: (context, state) {
        if(state is TransactionSuccess){  return  Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  TransactionCard(transaction: state.transactions[index]),
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              itemCount: state.transactions.length,
            ),
          );}
          else if (state is TransactionError){
            return Center(
              child: Text(state.error),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
