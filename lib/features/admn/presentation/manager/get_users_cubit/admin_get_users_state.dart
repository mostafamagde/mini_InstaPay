part of 'admin_get_users_cubit.dart';

@immutable
sealed class AdminGetUsersState {}

final class AdminGetUsersInitial extends AdminGetUsersState {}
final class AdminGetUsersLoading extends AdminGetUsersState {}
final class AdminGetUsersFailure extends AdminGetUsersState {
  final String errorMessage;

   AdminGetUsersFailure({required this.errorMessage });
}
final class AdminGetUsersSuccess extends AdminGetUsersState {
  final List<AdminUsersModel> users;

   AdminGetUsersSuccess({required this.users });
}
