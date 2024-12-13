import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/notifications/data/models/notfication_model.dart';

class NotificationsRepo{
  final _apiManger= ApiManager();
  Future<List<NotificationModel>> getAllNotifications() async{
   final response= await _apiManger.get(ApiConstants.getAllNotifications,headers: {"token":UserModel.getInstance().token});
   return (response.data['data'] as List)
    .map((item) => NotificationModel.fromJson(item))
    .toList();
   }
     Future<void> readNotifications(NotificationModel notification) async{
      await _apiManger.patch(
    ApiConstants.readNotifications+notification.id,
   headers: {"token":UserModel.getInstance().token});
     }
}