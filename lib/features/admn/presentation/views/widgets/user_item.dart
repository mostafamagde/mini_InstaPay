import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../core/utils/Constants.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        startActionPane:
            ActionPane(motion: const DrawerMotion(), extentRatio: .2, children: [
          SlidableAction(

            padding: EdgeInsets.only(right: 10),
            backgroundColor: Constants.backgroundColor,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (BuildContext context) {},

          ),
        ]),
        child: Container(
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
            children: [
              Container(
                width: media.width * .2,
                height: media.height * .08,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/InstaLogo.png"),
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                "mostafamagde227@gmail.com",
                overflow: TextOverflow.fade,
                maxLines: 1,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
