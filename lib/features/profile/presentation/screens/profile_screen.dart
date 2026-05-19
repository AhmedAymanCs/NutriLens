import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_back_button.dart';
import 'package:nutrilens/features/profile/presentation/logic/profile_cubit.dart';
import 'package:nutrilens/features/profile/presentation/logic/profile_state.dart';
import 'package:nutrilens/features/profile/presentation/widgets/custom_list_tile.dart';
import 'package:nutrilens/features/profile/presentation/widgets/custom_sign_up_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings', style: AppTextStyle.font22PrimaryBold),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: const CustomBackButton(),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.failure) {}
        },
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  color: ColorsManager.backgroundWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: const NetworkImage(
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fHww",
                      ),
                      radius: 50.r,
                    ),
                    heightSpace(24),
                    Text(
                      "Mohammed Waleed",
                      style: AppTextStyle.font18BlackBold,
                    ),
                    const Text("example@email.com"),
                    heightSpace(15),
                    Wrap(
                      children: [
                        Container(
                          width: 120.w,
                          height: 25.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryLight,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Text(
                            " 🔥 24 Day Streak",
                            style: AppTextStyle.font13GreyW400,
                          ),
                        ),
                        widthSpace(10),
                        Container(
                          width: 100.w,
                          height: 25.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorsManager.gray200,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Text(
                            "Pro Member",
                            style: AppTextStyle.font11BlackW600,
                          ),
                        ),
                      ],
                    ),
                    heightSpace(20),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 220.w,
                        height: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorsManager.gray200,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Wrap(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: ColorsManager.primary,
                              size: 20.r,
                            ),
                            widthSpace(10),
                            Text(
                              "Edit Profile",
                              style: AppTextStyle.font16BlackBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(24),
              Text('App Preferences', style: AppTextStyle.font18BlackBold),
              CustomListTile(
                title: 'Dark Mode',
                subtitle: 'Enable dark theme for the app',
                value: true,
                onChanged: (value) {},
                icon: Icons.dark_mode,
              ),
              CustomListTile(
                title: 'Notifications',
                subtitle: 'Receive reminders and updates',
                value: false,
                onChanged: (value) {},
                icon: Icons.notifications_active_outlined,
              ),
              heightSpace(32),
              const CustomSignOutButton(),
              heightSpace(24),
            ],
          );
        },
      ),
    );
  }
}
