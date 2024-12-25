part of 'cinfirm_forget_pin_cubit.dart';

@immutable
sealed class CinfirmForgetPinState {}

final class CinfirmForgetPinInitial extends CinfirmForgetPinState {}
final class CinfirmForgetPinLoading extends CinfirmForgetPinState {}
final class CinfirmForgetPinSuccess extends CinfirmForgetPinState {
  final String errorMessage;
   CinfirmForgetPinSuccess({required this.errorMessage });
}
final class CinfirmForgetPinFailed extends CinfirmForgetPinState {
  final String errorMessage;
  CinfirmForgetPinFailed({required this.errorMessage });
}
