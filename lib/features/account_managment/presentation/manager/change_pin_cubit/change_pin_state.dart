part of 'change_pin_cubit.dart';

@immutable
sealed class ChangePinState {}

final class ChangePinInitial extends ChangePinState {}
final class ChangePinLoading extends ChangePinState {}
final class ChangePinSuccess extends ChangePinState {
  final String message;

  ChangePinSuccess({required this.message });
}
final class ChangePinFailed extends ChangePinState {
  final String message;

  ChangePinFailed({required this.message });
}
