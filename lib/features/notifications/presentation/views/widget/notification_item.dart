import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/notifications/data/models/notfication_model.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
  });

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        notification.isRead
            ? Icons.notifications_none
            : Icons.notifications_active,
        color: notification.isRead ? Colors.grey : Constants.secondaryOrangeColor,
      ),
      title: Text(
        notification.content,
        style: TextStyle(
          fontWeight: notification.isRead
              ? FontWeight.normal
              : FontWeight.bold,
        ),
      ),
      subtitle: Text(
        notification.createdAt.toLocal().toString(),
        style: const TextStyle(fontSize: 12),
      ),
      trailing: notification.isRead
          ? null
          : Icon(
              Icons.circle,
              color: Colors.red,
              size: 10,
            ),
      onTap: () {
        if(!notification.isRead)
       BlocProvider.of<NotificationsCubit>(context).readNotification(notification);
      },
    );
  }
}