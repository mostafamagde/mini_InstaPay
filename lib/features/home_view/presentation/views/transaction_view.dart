import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled2/features/home_view/data/model/transaction_model.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_card.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key,});
  
  @override
  Widget build(BuildContext context) {
  final transactions= ModalRoute.of(context)?.settings.arguments as List<TransactionModel>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.separated(
          itemBuilder: (context, index) => TransactionCard(transaction: transactions[index]), 
          separatorBuilder: (context, index) => SizedBox(height: 16,),
          itemCount: transactions.length,
        ),
      ),
    );
  }
}