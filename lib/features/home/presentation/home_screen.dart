import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/features/auth/data/models/user_model.dart';
part 'shared_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userModel});
  final UserDataModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(userModel.uid, style: AppTextStyle.font32PrimaryBold),
            Text(userModel.name!, style: AppTextStyle.font32PrimaryBold),
            Text(userModel.weight!, style: AppTextStyle.font32PrimaryBold),
            Text(userModel.email, style: AppTextStyle.font32PrimaryBold),
            Text(
              userModel.age.toString(),
              style: AppTextStyle.font32PrimaryBold,
            ),
            Text(userModel.gender!, style: AppTextStyle.font32PrimaryBold),
            Text(userModel.gender!, style: AppTextStyle.font32PrimaryBold),
            Text(userModel.goal!, style: AppTextStyle.font32PrimaryBold),
          ],
        ),
      ),
    );
  }
}
