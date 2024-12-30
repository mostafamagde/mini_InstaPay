import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/constants.dart';
import 'package:mini_instapay/features/notifications/data/models/notfication_model.dart';
import 'package:mini_instapay/features/notifications/presentation/manger/notifications/notifications_cubit.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        notification.isRead ? Icons.notifications_none : Icons.notifications_active,
        color: notification.isRead ? Colors.grey : Constants.secondaryOrangeColor,
      ),
      title: Text(
        notification.content,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(
        notification.createdAt.toLocal().toString(),
        style: const TextStyle(fontSize: 12),
      ),
      trailing: (notification.type == Constants.requestSendString && UserModel.instance.role != Role.admin) || (notification.type == Constants.kRequestRefund && UserModel.instance.role == Role.admin)
          ? notification.isRead
              ? Text("Closed")
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (notification.type == Constants.requestSendString) {
                          BlocProvider.of<NotificationsCubit>(context).rejectRequest(notification: notification);
                        } else {
                          BlocProvider.of<NotificationsCubit>(context).rejectRefund(notification: notification);
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (notification.type == Constants.requestSendString) {
                          Navigator.pushNamed(context, RoutesNames.notificationsPin, arguments: notification);
                        } else {
                          BlocProvider.of<NotificationsCubit>(context).acceptRefund(notification: notification);
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                )
          : notification.isRead
              ? null
              : Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10,
                ),
      onTap: () {
        if (!notification.isRead) {
          if (notification.type != Constants.requestSendString) {
            BlocProvider.of<NotificationsCubit>(context).readNotification(notification.id);
          }
        }
      },
    );
  }
}
