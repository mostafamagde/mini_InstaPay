import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.notifications);
      },
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesNames.notifications);
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30.r,
            ),
          ),
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsSuccess) {
                final unreadCount = state.notifications.where((notification) => !notification.isRead).length;
                return Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Constants.primaryMouveColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${unreadCount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
