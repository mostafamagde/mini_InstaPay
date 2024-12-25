part of 'forget_pin_cubit.dart';

@immutable
sealed class ForgetPinState {}

final class ForgetPinInitial extends ForgetPinState {}

final class ForgetPinLoading extends ForgetPinState {}

final class ForgetPinFailure extends ForgetPinState {
  final String errMessage;
  ForgetPinFailure(this.errMessage);
}

final class ForgetPinSuccess extends ForgetPinState {
  final String userToken;
  ForgetPinSuccess(this.userToken);
}
