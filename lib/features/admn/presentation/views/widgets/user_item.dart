import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Slidable(
      startActionPane: ActionPane(motion: const DrawerMotion(), children: [   SlidableAction(
        backgroundColor: const Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,

        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        ), onPressed: (BuildContext context) {  },
      ),
        SlidableAction(

          icon: Icons.edit, onPressed: (BuildContext context) {  },

        ),]),

      child: Container(
        height: media.height * .1,
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
              width: media.width*.2,
              height: media.height*.08,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/InstaLogo.png"),
                ),
              ),
            ),

            Text("mostafamagde227@gmail.com")

          ],
        ),
      ),
    );
  }
}
