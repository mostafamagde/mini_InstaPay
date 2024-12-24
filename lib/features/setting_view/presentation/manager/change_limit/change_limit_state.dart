part of 'change_limit_cubit.dart';

@immutable
abstract class ChangeLimitState {}

class ChangeLimitInitial extends ChangeLimitState {}

class ChangeLimitLoading extends ChangeLimitState {}

class ChangeLimitSuccess extends ChangeLimitState {
  final String message;

  ChangeLimitSuccess(this.message);
}

class ChangeLimitError extends ChangeLimitState {
  final String message;

  ChangeLimitError(this.message);
}
