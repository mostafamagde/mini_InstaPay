part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsFailed extends NotificationsState {
  final String errorMessage;

  NotificationsFailed({required this.errorMessage});
}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;

  NotificationsSuccess({required this.notifications});
}

final class ReadNotificationsLoading extends NotificationsState {}

final class ReadNotificationsFailed extends NotificationsState {
  final String errorMessage;
  ReadNotificationsFailed({required this.errorMessage});
}

final class ReadNotificationsSuccess extends NotificationsState {
  final String notificationId;

  ReadNotificationsSuccess({required this.notificationId});
}
