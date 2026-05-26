import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/font_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/features/splash/logic/cubit.dart';
import 'package:nutrilens/features/splash/logic/states.dart';

class SplashScreen extends StatelessWidget {
  final SecureStorageHelper secureStorageHelper;
  const SplashScreen({super.key, required this.secureStorageHelper});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(secureStorageHelper)..startSplash(),
      child: BlocListener<SplashCubit, SplashStates>(
        listener: (context, state) {
          if (state is SplashAuthenticatedState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.navigationBar,
              (_) => false,
              arguments: state.userModel,
            );
          } else if (state is SplashLoginState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (_) => false,
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Image.asset(
                  ImageManager.logo,
                  height: 150.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20.h),
                Text(
                  StringManager.appDescription,
                  style: TextStyle(
                    color: ColorsManager.primary,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s16,
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
