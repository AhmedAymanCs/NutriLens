import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/services/local_notification_service.dart';
import 'package:nutrilens/features/profile/logic/cubit.dart';
import 'package:nutrilens/core/theme/cubit/cubit.dart';
import 'package:nutrilens/features/profile/presentation/notification_cubit.dart';

part 'shared_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance<ProfileCubit>()..getUserProfile(),
        ),
      ],
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ProfileStatus.success && state.user == null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          }

          if (state.status == ProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error.isNotEmpty
                      ? state.error
                      : "حدث خطأ ما، حاول مرة أخرى",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsManager.error,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: "Retry",
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<ProfileCubit>().getUserProfile();
                  },
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'NutriLens',
              style: AppTextStyle.font16PrimaryBold.copyWith(
                fontSize: 20.sp,
                color:
                    Theme.of(context).textTheme.titleLarge?.color ??
                    ColorsManager.primary,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_active_outlined),
              ),
            ],
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.primary,
                  ),
                );
              }

              if (state.status == ProfileStatus.failure) {
                return _buildErrorWidget(context);
              }

              return RefreshIndicator(
                onRefresh: () => context.read<ProfileCubit>().getUserProfile(),
                color: ColorsManager.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    children: [
                      _buildProfileHeaderCard(context, state),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Preferences",
                          style: AppTextStyle.font18BlackBold.copyWith(
                            color: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.color,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildSettingsList(context),
                      SizedBox(height: 32.h),
                      _buildLogoutButton(context),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeaderCard(BuildContext context, ProfileState state) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = state.user;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45.r,
            backgroundColor: isDark
                ? ColorsManager.darkGrey
                : ColorsManager.lighterGrey,
            backgroundImage: user?.photoUrl != null
                ? NetworkImage(user!.photoUrl!)
                : null,
            child: user?.photoUrl == null
                ? Icon(Icons.person, size: 50.sp, color: ColorsManager.primary)
                : null,
          ),
          SizedBox(height: 16.h),
          Text(
            user?.name ?? "Ahmed Abdelghany",
            style: AppTextStyle.font24BlackW700.copyWith(
              color: theme.textTheme.displayLarge?.color,
            ),
          ),
          Text(
            user?.email ?? "ahmedabdelghany6666@example.com",
            style: AppTextStyle.font13GreyW400.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallBadge(
                context: context,
                icon: Icons.local_fire_department,
                text: "${user?.streakCount ?? 0} Day Streak",
                isPrimaryBadge: false,
              ),
              SizedBox(width: 8.w),
              _buildSmallBadge(
                context: context,
                icon: Icons.star,
                text: "Pro Member",
                isPrimaryBadge: false,
              ),
              //عشان اتاكد انه برو  دي لما اشغلها مع الفاير بيز

              //   if (user?.isPro == true) ...[
              //   SizedBox(width: 8.w),
              //   _buildSmallBadge(
              //     context: context,
              //     icon: Icons.star,
              //     text: "Pro Member",
              //     isPrimaryBadge: false,
              //   ),
              // ],
            ],
          ),
          SizedBox(height: 20.h),
          InkWell(
            // onTap: () =>
            //     Navigator.pushNamed(context, Routes.editProfile).then((_) {
            //       context.read<ProfileCubit>().getUserProfile();
            //     }),
            borderRadius: BorderRadius.circular(25.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : ColorsManager.lighterGrey,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 18.sp, color: theme.iconTheme.color),
                  SizedBox(width: 8.w),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.labelLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallBadge({
    required BuildContext context,
    required IconData icon,
    required String text,
    required bool isPrimaryBadge,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isPrimaryBadge
        ? ColorsManager.primary.withOpacity(isDark ? 0.2 : 0.1)
        : (isDark ? Colors.white.withOpacity(0.05) : ColorsManager.lighterGrey);

    final Color contentColor = isPrimaryBadge
        ? ColorsManager.primary
        : (isDark ? Colors.white70 : ColorsManager.darkGrey);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: contentColor),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: contentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        const ProfileMenuItem(
          icon: Icons.flag_outlined,
          title: "Goal Settings",
          subtitle: "Macros, Calories & Targets",
        ),
        ProfileMenuItem(
          icon: Icons.notifications_outlined,
          title: "Notifications",
          subtitle: "Enable Cloud Messaging",
          onTap: () async {
            await FirebaseMessaging.instance.subscribeToTopic("all_users");

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Notifications Enabled Successfully!"),
              ),
            );
          },
        ),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return ProfileMenuItem(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              subtitle: "Adjust appearance",
              trailing: Switch(
                value: mode == ThemeMode.dark,
                activeColor: ColorsManager.primary,
                onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => context.read<ProfileCubit>().logout(),
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        width: double.infinity,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: ColorsManager.error.withOpacity(isDark ? 0.3 : 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: ColorsManager.error, size: 20.sp),
            SizedBox(width: 10.w),
            Text(
              "Sign Out",
              style: TextStyle(
                color: ColorsManager.error,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 80.sp,
              color: ColorsManager.error.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              "عفواً، فشل تحميل البيانات",
              style: AppTextStyle.font18BlackBold.copyWith(
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "تأكد من اتصالك بالإنترنت وحاول مرة أخرى",
              textAlign: TextAlign.center,
              style: AppTextStyle.font13GreyW400,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.read<ProfileCubit>().getUserProfile(),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                "إعادة المحاولة",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
