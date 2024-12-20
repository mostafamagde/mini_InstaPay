part of 'change_credinitials_cubit.dart';

@immutable
sealed class ChangeCredinitialsState {}

final class ChangeCredinitialsInitial extends ChangeCredinitialsState {}

final class ChangeCredinitialsLoading extends ChangeCredinitialsState {}

final class ChangeCredinitialsFailure extends ChangeCredinitialsState {
  final String errorMessage;
  ChangeCredinitialsFailure(this.errorMessage);
}

final class ChangeCredinitialsSuccess extends ChangeCredinitialsState {
  final String message;
  ChangeCredinitialsSuccess(this.message);
}
