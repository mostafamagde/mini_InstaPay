part of 'manage_bank_accounts_cubit.dart';

@immutable
sealed class ManageBankAccountsState {}

final class ManageBankAccountsInitial extends ManageBankAccountsState {}

final class ManageBankAccountsLoading extends ManageBankAccountsState {}

final class ManageBankAccountsFailed extends ManageBankAccountsState {
  final String message;

  ManageBankAccountsFailed(this.message);
}

final class ManageBankAccountsSuccess extends ManageBankAccountsState {
  final String? message;

  ManageBankAccountsSuccess({this.message});
}

final class ManageBankAccountsDeleteFailed extends ManageBankAccountsState {
  final String message;

  ManageBankAccountsDeleteFailed(this.message);
}
