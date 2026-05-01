import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/models/user_model.dart';
part 'shared_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("UID: ${userModel.uid}", style: AppTextStyle.font18BlackBold),
            Text(
              "Name: ${userModel.name}",
              style: AppTextStyle.font18BlackBold,
            ),
            Text(
              "Weight: ${userModel.weight}",
              style: AppTextStyle.font18BlackBold,
            ),
            Text(
              "Email: ${userModel.email}",
              style: AppTextStyle.font18BlackBold,
            ),
            Text("Age: ${userModel.age}", style: AppTextStyle.font18BlackBold),
            Text(
              "Gender: ${userModel.gender}",
              style: AppTextStyle.font18BlackBold,
            ),
            Text(
              "Goal: ${userModel.goal}",
              style: AppTextStyle.font18BlackBold,
            ),
          ],
        ),
      ),
    );
  }
}
