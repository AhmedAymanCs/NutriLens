part of 'profile_screen.dart';

class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        AppConstants.appName,
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
      Badge(
  label: Text('3'), 
  backgroundColor: const Color.fromARGB(255, 175, 76, 92), 
  textColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 5),
  largeSize: 20, 
  child: Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(
      Icons.notifications_none,
      size: 24,
    ),
  ),
)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ProfileHeaderCard extends StatelessWidget {
  final dynamic user;

  const ProfileHeaderCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            user?.name ?? AppConstants.defaultUserName,
            style: AppTextStyle.font24BlackW700.copyWith(
              color: theme.textTheme.displayLarge?.color,
            ),
          ),
          Text(
            user?.email ?? AppConstants.defaultUserEmail,
            style: AppTextStyle.font13GreyW400.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 16.h),
          const _BadgesRow(),
          SizedBox(height: 20.h),
          ProfileEditButton(
            onTap: () {
              // Navigator.pushNamed(context, Routes.editProfile);
            },
          ),
        ],
      ),
    );
  }
}

class _BadgesRow extends StatelessWidget {
  const _BadgesRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ProfileHeaderBadge(
          icon: Icons.local_fire_department,
          text: AppConstants.zeroDayStreak,
          isPrimary: false,
        ),
        SizedBox(width: 8.w),
        const ProfileHeaderBadge(
          icon: Icons.star,
          text: AppConstants.proMember,
          isPrimary: false,
        ),
      ],
    );
  }
}

class ProfileHeaderBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isPrimary;

  const ProfileHeaderBadge({
    super.key,
    required this.icon,
    required this.text,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isPrimary
        ? ColorsManager.primary
        : (isDark ? Colors.white70 : ColorsManager.darkGrey);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isPrimary
            ? ColorsManager.primary.withOpacity(0.1)
            : (isDark
                  ? Colors.white.withOpacity(0.05)
                  : ColorsManager.lighterGrey),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileMenuItem(
          icon: Icons.flag_outlined,
          title: AppConstants.goalSettingsTitle,
          subtitle: AppConstants.goalSettingsSubtitle,
        ),
        ProfileMenuItem(
          icon: Icons.notifications_outlined,
          title: AppConstants.notificationsTitle,
          subtitle: AppConstants.notificationsSubtitle,
          onTap: () async {
            await FirebaseMessaging.instance.subscribeToTopic("all_users");
            // AppSnackBar.showSuccess(context, "Notifications Enabled!");
          },
        ),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return ProfileMenuItem(
              icon: Icons.dark_mode_outlined,
              title: AppConstants.darkModeTitle,
              subtitle: AppConstants.darkModeSubtitle,
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
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: ColorsManager.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: ColorsManager.primary, size: 24.sp),
      ),
      title: Text(
        title,
        style: AppTextStyle.font18BlackBold.copyWith(fontSize: 16.sp),
      ),
      subtitle: Text(subtitle, style: AppTextStyle.font13GreyW400),
      trailing:
          trailing ??
          Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<ProfileCubit>().logout(),
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        width: double.infinity,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: ColorsManager.error.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: ColorsManager.error, size: 20.sp),
            SizedBox(width: 10.w),
            Text(
              AppConstants.signOut,
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
}

class ProfileErrorWidget extends StatelessWidget {
  const ProfileErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 80.sp,
            color: ColorsManager.error.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          const Text("عفواً، فشل تحميل البيانات"),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<ProfileCubit>().getUserProfile(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
            ),
            child: const Text(
              "إعادة المحاولة",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferencesHeader extends StatelessWidget {
  const _PreferencesHeader();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Preferences",
        style: AppTextStyle.font18BlackBold.copyWith(
          color: Theme.of(context).textTheme.headlineMedium?.color,
        ),
      ),
    );
  }
}

class ProfileEditButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileEditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : ColorsManager.lighterGrey,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              "Edit Profile",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
