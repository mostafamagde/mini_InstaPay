part of 'change_email_cubit.dart';

@immutable
sealed class ChangeEmailState {}

final class ChangeEmailInitial extends ChangeEmailState {}
final class ChangeEmailLoading extends ChangeEmailState {}
final class ChangeEmailFailure extends ChangeEmailState {
  final String errMessage;
  ChangeEmailFailure(this.errMessage);
}
final class ChangeEmailSuccess extends ChangeEmailState {
  final String message;
  ChangeEmailSuccess(this.message);
}
