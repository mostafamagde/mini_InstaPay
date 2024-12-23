import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_monthly_transactions.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

part 'transaction_summary_view_state.dart';

class TransactionSummaryViewCubit extends Cubit<TransactionSummaryViewState> {
  TransactionSummaryViewCubit(this.getMonthlyTransactionsUseCase, this.getAnnualTransactionsUseCase) : super(TransactionSummaryViewInitial());

  final GetMonthlyTransactions getMonthlyTransactionsUseCase;
  final GetAnnualTransactions getAnnualTransactionsUseCase;

  Future<void> getMonthlyTransactions(String month) async {
    try {
      emit(TransactionSummaryViewLoading());
      List<TransactionModel> res = await getMonthlyTransactionsUseCase.getMonthlyTransactions(month);
      emit(TransactionSummaryViewSuccess(res));
    } catch (_) {
      emit(TransactionSummaryViewFailed());
    }
  }

  Future<void> getAnnualTransactions(int year) async {
    try {
      emit(TransactionSummaryViewLoading());
      List<TransactionModel> res = await getAnnualTransactionsUseCase.getAnnualTransactions(year);
      emit(TransactionSummaryViewSuccess(res));
    } catch (_) {
      emit(TransactionSummaryViewFailed());
    }
  }
}
