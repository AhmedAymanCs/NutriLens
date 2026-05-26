import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/features/profile/logic/profile_cubit.dart';
import 'package:nutrilens/features/profile/logic/profile_state.dart';

class EditProfileDialog extends StatefulWidget {
  final ProfileCubit cubit;
  const EditProfileDialog({super.key, required this.cubit});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameController;
  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state.status == ProfileStatus.success) {
          Navigator.of(context).pop();
          customSnackBar(
            context: context,
            message: StringManager.profileUpdated,
            isErrorMessage: false,
          );
        }
        if (state.status == ProfileStatus.failure) {
          customSnackBar(context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 30,
              //       vertical: 15,
              //     ),
              //     child: state.file == null
              //         ? Image.asset(
              //             ImageManager.placeholder,
              //             fit: BoxFit.contain,
              //           )
              //         : Image.file(File(state.file!.path), fit: BoxFit.contain),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: CustomButton(
              //           text: StringManager.camera,
              //           onPressed: () =>
              //               widget.cubit.pickImage(ImageSource.camera),
              //         ),
              //       ),
              //       const SizedBox(width: 16),
              //       Expanded(
              //         child: CustomButton(
              //           text: StringManager.gallery,
              //           onPressed: () =>
              //               widget.cubit.pickImage(ImageSource.gallery),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20,
                ),
                child: CustomFormField(
                  hint: 'New Name',
                  controller: _nameController,
                ),
              ),
              CustomButton(
                text: 'Update',
                onPressed: () => widget.cubit.editProfile(
                  state.user!.copyWith(name: _nameController.text),
                ),
              ),

              heightSpace(15),
            ],
          ),
        );
      },
    );
  }
}

class CustomSignOutButton extends StatelessWidget {
  const CustomSignOutButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorsManager.error.withValues(alpha: 0.25)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout_outlined, color: ColorsManager.error, size: 20.r),
          widthSpace(15),
          Text(StringManager.signOut, style: AppTextStyle.font16RedW600),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;
  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpace(16),
        SwitchListTile(
          dense: true,
          thumbIcon: WidgetStatePropertyAll(
            Icon(icon, color: ColorsManager.backgroundWhite),
          ),
          thumbColor: const WidgetStatePropertyAll(ColorsManager.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          title: Text(title, style: AppTextStyle.font16BlackBold(context)),
          subtitle: Text(subtitle, style: AppTextStyle.font13GreyW400(context)),

          value: value,
          onChanged: onChanged,
          activeThumbColor: ColorsManager.primary,
        ),
      ],
    );
  }
}
