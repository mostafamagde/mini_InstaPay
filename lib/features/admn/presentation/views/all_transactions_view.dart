import 'package:flutter/cupertino.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/transaction_item.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/transaction_list_view.dart';

class AllTransactionsView extends StatelessWidget {
  const AllTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    Size media =MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: media.width*.05),
      child: Column(

        children: [
          TransactionListView()



        ],
      ),
    );
  }
}
