import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/features/admin/data/models/AdminUsersModel.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.users, required this.onPressed});

  final AdminUsersModel users;
  final Future<void> Function(AdminUsersModel user) onPressed;

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: media.width * .05),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: .2,
          children: [
            SlidableAction(
              padding: EdgeInsets.only(right: 10),
              backgroundColor: Constants.backgroundColor,
              foregroundColor: Colors.red,
              icon: Icons.hide_source_sharp,
              onPressed: (context) => onPressed(users),
            ),
          ],
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 90,
          width: media.width * .9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: .5,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: media.width * .2,
                height: media.height * .08,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      users.status == "Suspended" ? "assets/images/ban.png" : "assets/images/InstaLogo.png",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${users.email!}",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      overflow: TextOverflow.fade,
                      "${users.userName!}",
                      maxLines: 1,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      overflow: TextOverflow.fade,
                      "${users.mobileNumber}",
                      maxLines: 1,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Constants.primaryMouveColor),
                    child: Center(
                      child: Text(
                        users.role!,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                        color: Colors.grey),
                    child: Center(
                      child: Text(
                        users.createdAt!.substring(2, 10),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
