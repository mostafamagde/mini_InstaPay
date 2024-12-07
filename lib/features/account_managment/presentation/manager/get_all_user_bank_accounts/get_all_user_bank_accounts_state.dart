part of 'get_all_user_bank_accounts_cubit.dart';

@immutable
sealed class GetAllUserBankAccountsState {}

final class GetAllUserBankAccountsInitial extends GetAllUserBankAccountsState {}

final class GetAllUserBankAccountsLoading extends GetAllUserBankAccountsState {}

final class GetAllUserBankAccountsFailed extends GetAllUserBankAccountsState {
  final String message;

  GetAllUserBankAccountsFailed(this.message);
}

final class GetAllUserBankAccountsSuccess extends GetAllUserBankAccountsState {
  final List<BankAccountModel> bankAccounts;

  GetAllUserBankAccountsSuccess(this.bankAccounts);
}
