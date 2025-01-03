import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/features/reports/data/models/one_user_transactions_model.dart';
import 'package:mini_instapay/features/reports/domain/use_cases/get_each_user_transactions.dart';

part 'usage_analysis_state.dart';

class UsageAnalysisCubit extends Cubit<UsageAnalysisState> {
  UsageAnalysisCubit(this._getEachUserTransactions) : super(UsageAnalysisInitial());

  final GetEachUserTransactions _getEachUserTransactions;

  Future<void> getEachUserTransactions() async {
    try {
      emit(UsageAnalysisLoading());
      List<OneUserTransactionsModel> res = await _getEachUserTransactions.getEachUserTransactions();
      emit(UsageAnalysisSuccess(res, res.isEmpty ? OneUserTransactionsModel.init() : res.first));
    } catch (_) {
      emit(UsageAnalysisFailed());
    }
  }

  Future<void> refresh(List<OneUserTransactionsModel> models, OneUserTransactionsModel showedModel) async {
    emit(UsageAnalysisSuccess(models, showedModel));
  }
}
