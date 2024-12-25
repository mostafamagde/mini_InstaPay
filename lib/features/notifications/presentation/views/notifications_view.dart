import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/socket_service.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/notifications/data/models/notfication_model.dart';
import 'package:mini_instapay/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:mini_instapay/features/notifications/presentation/views/widget/notification_item.dart';

// ignore: must_be_immutable
class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);
  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationsCubit>(context).getNotification();
    final s = SocketService.instance.stream;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            UserModel.instance.role == Role.Admin
                ? Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesNames.adminLayout,
                    (Route<dynamic> route) => false,
                  )
                : Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesNames.layoutView,
                    (Route<dynamic> route) => false,
                  );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
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
          }

          return StreamBuilder<NotificationModel>(
            stream: s,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (snapshot.data != null) {
                  if (notifications.length != 0) {
                    if ((snapshot.data as NotificationModel).id != notifications[0].id) {
                      notifications.insert(0, snapshot.data);
                    }
                  } else {
                    notifications.add(snapshot.data);
                  }
                }
                if (notifications.isEmpty) {
                  return Center(
                    child: Text(
                      "No notifications available",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  );
                }
                return ModalProgressHUD(
                  inAsyncCall: state is ReadNotificationsLoading,
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return Column(
                        children: [
                          NotificationItem(notification: notification),
                          Divider(),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
