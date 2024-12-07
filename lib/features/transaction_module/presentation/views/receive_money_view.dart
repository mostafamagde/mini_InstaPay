import 'package:flutter/cupertino.dart';

import '../../../../core/models/user_model.dart';

class ReceiveMoneyView extends StatelessWidget {
  const ReceiveMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    print(UserModel.getInstance().token);
    return Center(
      child: Text("receive money",style: TextStyle(fontSize: 50),),
    );
  }
}
