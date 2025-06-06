import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/features/reports/data/models/transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:mini_instapay/features/reports/domain/use_cases/get_monthly_transactions.dart';

part 'transaction_summary_view_state.dart';

class TransactionSummaryViewCubit extends Cubit<TransactionSummaryViewState> {
  TransactionSummaryViewCubit(this._getMonthlyTransactionsUseCase, this._getAnnualTransactionsUseCase) : super(TransactionSummaryViewInitial());

  final GetMonthlyTransactions _getMonthlyTransactionsUseCase;
  final GetAnnualTransactions _getAnnualTransactionsUseCase;
  bool showMonth = false;

  Future<void> getMonthlyTransactions(String month, int year) async {
    try {
      emit(TransactionSummaryViewLoading());
      TransactionSummaryModel res = await _getMonthlyTransactionsUseCase.getMonthlyTransactions(month, year);
      emit(TransactionSummaryViewSuccess(res));
    } catch (_) {
      emit(TransactionSummaryViewFailed());
    }
  }

  Future<void> getAnnualTransactions(int year) async {
    try {
      emit(TransactionSummaryViewLoading());
      TransactionSummaryModel res = await _getAnnualTransactionsUseCase.getAnnualTransactions(year);
      emit(TransactionSummaryViewSuccess(res));
    } catch (_) {
      emit(TransactionSummaryViewFailed());
    }
  }
}
