part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionError extends TransactionState {
  final String error;

  TransactionError({required this.error});
}

final class TransactionSuccess extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionSuccess({required this.transactions});
}
