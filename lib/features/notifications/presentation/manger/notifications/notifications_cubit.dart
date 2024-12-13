import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/notifications/data/models/notfication_model.dart';
import 'package:untitled2/features/notifications/data/repository/notifications_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
 final NotificationsRepo notificationsRepo;
  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitial());
  getNotification()async{
 try{   emit(NotificationsLoading());
   List<NotificationModel> notifications= await notificationsRepo.getAllNotifications();
    emit(NotificationsSuccess(notifications: notifications));}
    catch(e){
      if(e is DioException){
        emit(NotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      }
      else{emit(NotificationsFailed(errorMessage: e.toString()));}
    }
  }
   readNotification(NotificationModel notification)async{
 try{   emit(ReadNotificationsLoading());
     await notificationsRepo.readNotifications(notification);
    emit(ReadNotificationsSuccess(notification: notification));}
    catch(e){
      if(e is DioException){
        emit(ReadNotificationsFailed(errorMessage: e.response?.data["message"] ?? e.message));
      }
      else{emit(ReadNotificationsFailed(errorMessage: e.toString()));}
    }
  }
}
