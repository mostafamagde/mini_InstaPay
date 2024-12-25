import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/notifications/data/models/notfication_model.dart';

class NotificationsRepo {
  final ApiManager _apiManger;

  const NotificationsRepo(this._apiManger);

  Future<List<NotificationModel>> getAllNotifications() async {
    final response = await _apiManger.get(ApiConstants.getAllNotifications, headers: {"token": UserModel.instance.token});
    return (response.data['data'] as List).map((item) => NotificationModel.fromJson(item)).toList();
  }

  Future<void> readNotifications(String notificationId) async {
    await _apiManger.patch(ApiConstants.readNotifications + notificationId, headers: {"token": UserModel.instance.token});
  }

  Future<void> rejectRequest({required String transactionId}) async {
    await _apiManger.post(ApiConstants.rejectReceive + transactionId, {}, headers: {"token": UserModel.instance.token});
  }

  Future<void> acceptRequest({required String transactionId, String? accountId, required String pin}) async {
    final body = {"accountId": accountId, "PIN": pin};
    await _apiManger.post(ApiConstants.confirmReceive + transactionId, body, headers: {"token": UserModel.instance.token});
  }

  Future<void> rejectRefund({required String transactionId}) async {
    await _apiManger.post(ApiConstants.rejectRefund, {"transactionId": transactionId}, headers: {"token": UserModel.instance.token});
  }

  Future<void> acceptRefund({required String transactionId}) async {
    await _apiManger.post(ApiConstants.acceptRefund, {"transactionId": transactionId}, headers: {"token": UserModel.instance.token});
  }
}
