import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/theme/cubit/cubit.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/profile/presentation/logic/profile_cubit.dart';
import 'package:nutrilens/features/profile/presentation/logic/profile_state.dart';
import 'package:nutrilens/features/profile/presentation/widgets/custom_list_tile.dart';
import 'package:nutrilens/features/profile/presentation/widgets/custom_sign_up_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current.status == ProfileStatus.success,
      listener: (context, state) {
        if (state.status == ProfileStatus.failure) {
          customSnackBar(context: context, message: state.errorMessage);
        }

        if (state.status == ProfileStatus.signOutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        }
      },

      builder: (context, state) {
        return Skeletonizer(
          enabled: state.user == null,
          child: ListView(
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
                      backgroundImage: NetworkImage(
                        state.user?.photoURL ??
                            "https://cutiedp.com/wp-content/uploads/2025/08/no-dp-image-5.webp",
                      ),
                      radius: 50.r,
                    ),
                    heightSpace(24),
                    Text(
                      state.user?.name ?? "",
                      style: AppTextStyle.font18BlackBold,
                    ),
                    Text(state.user?.email ?? ""),
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
                            StringManager.profile24DayStreak,
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
                            StringManager.proMember,
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
                              StringManager.editProfile,
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
              Text(
                StringManager.appPreferences,
                style: AppTextStyle.font18BlackBold,
              ),
              CustomListTile(
                title: StringManager.darkMode,
                subtitle: StringManager.darkModeSubtitle,
                value: state.isDarkMode,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: Icons.dark_mode,
              ),
              CustomListTile(
                title: StringManager.notifications,
                subtitle: StringManager.notificationsSubtitle,
                value: state.isNotificationEnabled,
                onChanged: (value) {
                  context.read<ProfileCubit>().toggleNotification();
                },
                icon: Icons.notifications_active_outlined,
              ),
              heightSpace(32),
              CustomSignOutButton(
                onTap: state.status == ProfileStatus.loading
                    ? null
                    : () {
                        context.read<ProfileCubit>().signOut();
                      },
              ),
              heightSpace(24),
            ],
          ),
        );
      },
    );
  }
}
