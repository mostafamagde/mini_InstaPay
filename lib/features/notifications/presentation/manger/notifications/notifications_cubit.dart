import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/notifications/data/models/notfication_model.dart';
import 'package:untitled2/features/notifications/data/repository/notifications_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo notificationsRepo;
  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitial());
  getNotification() async {
    try {
      emit(NotificationsLoading());
      List<NotificationModel> notifications = await notificationsRepo.getAllNotifications();
      emit(NotificationsSuccess(notifications: notifications));
    } catch (e) {
      if (e is DioException) {
        emit(NotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      } else {
        emit(NotificationsFailed(errorMessage: e.toString()));
      }
    }
  }

  readNotification(String notificationId) async {
    try {
      emit(ReadNotificationsLoading());
      await notificationsRepo.readNotifications(notificationId);
      emit(ReadNotificationsSuccess(notificationId: notificationId));
    } catch (e) {
      if (e is DioException) {
        emit(ReadNotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      } else {
        emit(ReadNotificationsFailed(errorMessage: e.toString()));
      }
    }
  }

  acceptRequest({required NotificationModel notification, String? accountId, required String pin}) async {
    try {
      emit(ReadNotificationsLoading());

      await notificationsRepo.acceptRequest(transactionId: notification.transactionId, pin: pin, accountId: accountId);
      this.readNotification(notification.id);
    } catch (e) {
      if (e is DioException) {
        emit(ReadNotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      } else {
        emit(ReadNotificationsFailed(errorMessage: e.toString()));
      }
    }
  }

  rejectRequest({
    required NotificationModel notification,
  }) async {
    try {
      emit(ReadNotificationsLoading());
      await notificationsRepo.rejectRequest(transactionId: notification.transactionId);

      this.readNotification(notification.id);
    } catch (e) {
      if (e is DioException) {
        emit(ReadNotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      } else {
        emit(ReadNotificationsFailed(errorMessage: e.toString()));
      }
    }
  }
  rejectRefund({
    required NotificationModel notification,
  }) async {
    try {
      emit(ReadNotificationsLoading());
      await notificationsRepo.rejectRefund(transactionId: notification.transactionId);

      this.readNotification(notification.id);
    } catch (e) {
      if (e is DioException) {
        emit(ReadNotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      } else {
        emit(ReadNotificationsFailed(errorMessage: e.toString()));
      }
    }
  }
   acceptRefund({required NotificationModel notification}) async {
    try {
      emit(ReadNotificationsLoading());

      await notificationsRepo.acceptRefund(transactionId: notification.transactionId);
      this.readNotification(notification.id);
    } catch (e) {
      if (e is DioException) {
        emit(ReadNotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      } else {
        emit(ReadNotificationsFailed(errorMessage: e.toString()));
      }
    }
  }
  
  void emitState() {
    emit(NotificationsSuccess(notifications: []));
  }
}
