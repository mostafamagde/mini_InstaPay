part of 'send_cubit.dart';

@immutable
sealed class SendState {}

final class SendInitial extends SendState {}

final class SendLoading extends SendState {}

final class SendFailed extends SendState {
  final String error;

  SendFailed({required this.error});
}

final class SendSuccess extends SendState {
  final String message;

  SendSuccess({required this.message});
}
