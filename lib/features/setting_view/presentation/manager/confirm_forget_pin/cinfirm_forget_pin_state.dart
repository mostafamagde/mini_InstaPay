part of 'cinfirm_forget_pin_cubit.dart';

@immutable
sealed class ConfirmForgetPinState {}

final class CinfirmForgetPinInitial extends ConfirmForgetPinState {}
final class CinfirmForgetPinLoading extends ConfirmForgetPinState {}
final class CinfirmForgetPinSuccess extends ConfirmForgetPinState {
  final String errorMessage;
   CinfirmForgetPinSuccess({required this.errorMessage });
}
final class CinfirmForgetPinFailed extends ConfirmForgetPinState {
  final String errorMessage;
  CinfirmForgetPinFailed({required this.errorMessage });
}
