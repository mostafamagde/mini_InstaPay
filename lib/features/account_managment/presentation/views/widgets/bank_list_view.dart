import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';
import 'package:untitled2/features/account_managment/presentation/manager/get_all_banks/banks_cubit.dart';
import 'banks_list_item.dart';

class BankListView extends StatelessWidget {
  const BankListView({super.key, required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BanksCubit, BanksState>(
      listener: (context, state) {
        if (state is BanksError) {
          snackBar(content: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is BanksLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BanksLoaded) {
          List<BankModel> filterd = [];
          for (BankModel bank in state.banks) {
            if (bank.name.toUpperCase().contains(search.toUpperCase())) {
              filterd.add(bank);
            }
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: filterd.length,
            itemBuilder: (context, index) => BanksListItem(bank: filterd[index]),
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: NeverScrollableScrollPhysics(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
