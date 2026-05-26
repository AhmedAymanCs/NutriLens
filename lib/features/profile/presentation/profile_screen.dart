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
import 'package:nutrilens/features/profile/logic/profile_cubit.dart';
import 'package:nutrilens/features/profile/logic/profile_state.dart';
import 'package:nutrilens/features/profile/presentation/shared_widgets.dart';
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
        final cubit = context.read<ProfileCubit>();
        return Skeletonizer(
          enabled: state.user == null,
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Text(
                      state.user?.name ?? "",
                      style: AppTextStyle.font18BlackBold,
                    ),
                    Text(
                      state.user?.email ?? "",
                      style: AppTextStyle.font15GreyW500,
                    ),
                    heightSpace(20),
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => EditProfileDialog(cubit: cubit),
                      ),
                      child: Container(
                        width: 220.w,
                        height: 35.h,
                        alignment: Alignment.center,
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
                onChanged: (value) =>
                    context.read<ProfileCubit>().toggleDarkMode(context),

                icon: Icons.dark_mode,
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
