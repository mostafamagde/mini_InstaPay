part of 'ban_users_cubit.dart';

@immutable
sealed class BanUsersState {}

final class BanUsersInitial extends BanUsersState {}

final class BanUsersLoading extends BanUsersState {}

final class BanUsersSuccess extends BanUsersState {
  final String mssg;
  final AdminUsersModel user;

  BanUsersSuccess({required this.mssg, required this.user});
}

final class BanUsersFailure extends BanUsersState {
  final String error;

  BanUsersFailure({required this.error});
}
