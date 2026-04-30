part of 'profile_screen.dart';

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
          color: ColorsManager.backgroundLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: ColorsManager.primary, size: 24.sp),
      ),
      title: Text(title,
          style: AppTextStyle.font18BlackBold.copyWith(fontSize: 16.sp)),
      subtitle: Text(subtitle, style: AppTextStyle.font13GreyW400),
      trailing: trailing ??
          Icon(Icons.arrow_forward_ios,
              size: 16.sp, color: ColorsManager.textMuted),
    );
  }
}

class ProfileHeaderBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;

  const ProfileHeaderBadge({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: ColorsManager.primary),
          SizedBox(width: 4.w),
          Text(text,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.textPrimary)),
        ],
      ),
    );
  }
}

class ProfileEditButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileEditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 16.sp, color: ColorsManager.textPrimary),
            SizedBox(width: 8.w),
            Text("Edit Profile",
                style: AppTextStyle.font11BlackW600
                    .copyWith(color: ColorsManager.textPrimary)),
          ],
        ),
      ),
    );
  }
}