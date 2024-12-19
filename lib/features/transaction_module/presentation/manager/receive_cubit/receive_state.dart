part of 'receive_cubit.dart';

@immutable
sealed class ReceiveState {}

final class ReceiveInitial extends ReceiveState {}

final class ReceiveLoading extends ReceiveState {}

final class ReceiveSuccess extends ReceiveState {
  final String message;

  ReceiveSuccess({required this.message});
}

final class ReceiveFailed extends ReceiveState {
  final String errorMessage;

  ReceiveFailed({required this.errorMessage});
}
