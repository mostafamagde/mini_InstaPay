import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_monthly_transactions.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

part 'transaction_summary_view_state.dart';

class TransactionSummaryViewCubit extends Cubit<TransactionSummaryViewState> {
  TransactionSummaryViewCubit(this._getMonthlyTransactionsUseCase, this._getAnnualTransactionsUseCase) : super(TransactionSummaryViewInitial());

  final GetMonthlyTransactions _getMonthlyTransactionsUseCase;
  final GetAnnualTransactions _getAnnualTransactionsUseCase;
  bool showMonth = false;

  Future<void> getMonthlyTransactions(String month, int year) async {
    try {
      emit(TransactionSummaryViewLoading());
      List<TransactionModel> res = await _getMonthlyTransactionsUseCase.getMonthlyTransactions(month, year);
      emit(TransactionSummaryViewSuccess(res));
    } catch (_) {
      emit(TransactionSummaryViewFailed());
    }
  }

  Future<void> getAnnualTransactions(int year) async {
    try {
      emit(TransactionSummaryViewLoading());
      List<TransactionModel> res = await _getAnnualTransactionsUseCase.getAnnualTransactions(year);
      emit(TransactionSummaryViewSuccess(res));
    } catch (_) {
      emit(TransactionSummaryViewFailed());
    }
  }
}
