part of 'add_account_cubit.dart';

@immutable
sealed class AddAccountState {}

final class AddAccountInitial extends AddAccountState {}

final class AddAccountLoading extends AddAccountState {}

final class AddAccountFailed extends AddAccountState {
  final String errorMessage;

  AddAccountFailed({required this.errorMessage});
}

final class AddAccountSuccess extends AddAccountState {
  final String msg;

  AddAccountSuccess({required this.msg});
}
