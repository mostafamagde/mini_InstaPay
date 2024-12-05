import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/account_managment/presentation/banks_cubit/banks_cubit.dart';

import 'banks_list_item.dart';

class BankListView extends StatelessWidget {

  const BankListView({super.key});

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
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.banks.length,
            itemBuilder: (context, index) => BanksListItem(bank: state.banks[index]),
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
