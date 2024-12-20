import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/notifications/data/models/notfication_model.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:untitled2/features/notifications/presentation/views/widget/notification_item.dart';

// ignore: must_be_immutable
class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);
  List<NotificationModel> notifications = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationsCubit>(context).getNotification();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesNames.layoutView,
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationsSuccess) {
            notifications = state.notifications;
          } else if (state is ReadNotificationsFailed) {
            snackBar(content: state.errorMessage, context: context);
          } else if (state is ReadNotificationsSuccess) {
            final index = notifications.indexWhere((notification) => notification.id == state.notificationId);
            notifications[index].isRead = true;
          }
        },
        builder: (context, state) {
          if (state is NotificationsFailed) {
            return Center(child: Text(state.errorMessage));
          } else if (state is NotificationsLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications available",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ModalProgressHUD(
              inAsyncCall: state is ReadNotificationsLoading,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationItem(notification: notification);
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
