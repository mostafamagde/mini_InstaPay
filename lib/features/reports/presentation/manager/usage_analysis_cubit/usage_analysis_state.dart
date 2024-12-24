part of 'usage_analysis_cubit.dart';

@immutable
sealed class UsageAnalysisState {}

final class UsageAnalysisInitial extends UsageAnalysisState {}

final class UsageAnalysisLoading extends UsageAnalysisState {}

final class UsageAnalysisSuccess extends UsageAnalysisState {
  final List<OneUserTransactionsModel> oneUserTransactionsModels;
  final OneUserTransactionsModel showedModel;

  UsageAnalysisSuccess(this.oneUserTransactionsModels, this.showedModel);
}

final class UsageAnalysisFailed extends UsageAnalysisState {}
