part of 'get_balance_cubit.dart';

@immutable
sealed class GetBalanceState {}

final class GetBalanceInitial extends GetBalanceState {}
final class GetBalanceLoading extends GetBalanceState {}
final class GetBalanceSuccess extends GetBalanceState {
  final int balance;

   GetBalanceSuccess({required this.balance });
}
final class GetBalanceFailed extends GetBalanceState {
  final String error;

   GetBalanceFailed({required this.error });
}
