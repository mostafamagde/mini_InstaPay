part of 'change_cubit.dart';

@immutable
sealed class ChangeState {}

final class ChangeInitial extends ChangeState {}

final class ChangeFailed extends ChangeState {
  final String message;

  ChangeFailed({required this.message});
}

final class ChangeSuccess extends ChangeState {
  final String id;

  ChangeSuccess({required this.id});
}

final class ChangeLoading extends ChangeState {}
