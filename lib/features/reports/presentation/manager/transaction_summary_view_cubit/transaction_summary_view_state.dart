part of 'transaction_summary_view_cubit.dart';

@immutable
sealed class TransactionSummaryViewState {}

final class TransactionSummaryViewInitial extends TransactionSummaryViewState {}

final class TransactionSummaryViewLoading extends TransactionSummaryViewState {}

final class TransactionSummaryViewSuccess extends TransactionSummaryViewState {
  final List<TransactionModel> transactions;

  TransactionSummaryViewSuccess(this.transactions);
}

final class TransactionSummaryViewFailed extends TransactionSummaryViewState {}
