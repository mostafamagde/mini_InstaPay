import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/notifications/data/models/notfication_model.dart';

class NotificationsRepo {
  final _apiManger = ApiManager();
  Future<List<NotificationModel>> getAllNotifications() async {
    final response = await _apiManger.get(ApiConstants.getAllNotifications, headers: {"token": UserModel.getInstance().token});
    return (response.data['data'] as List).map((item) => NotificationModel.fromJson(item)).toList();
  }

  Future<void> readNotifications(String notificationId) async {
    await _apiManger.patch(ApiConstants.readNotifications + notificationId, headers: {"token": UserModel.getInstance().token});
  }

  Future<void> rejectRequest({required String transactionId}) async {
    await _apiManger.post(ApiConstants.rejectReceive + transactionId, {}, headers: {"token": UserModel.getInstance().token});
  }

  Future<void> acceptRequest({required String transactionId, String? accountId, required String pin}) async {
    final body = {"accountId": accountId, "PIN": pin};
    await _apiManger.post(ApiConstants.confirmReceive + transactionId, body, headers: {"token": UserModel.getInstance().token});
  }
  Future<void> rejectRefund({required String transactionId}) async {
    await _apiManger.post(ApiConstants.rejectRefund , {
      "transactionId": transactionId
    }, headers: {"token": UserModel.getInstance().token});
  }

  Future<void> acceptRefund({required String transactionId}) async {
  
    await _apiManger.post(ApiConstants.acceptRefund,{"transactionId": transactionId }, headers: {"token": UserModel.getInstance().token});
  }
}
