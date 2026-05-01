import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/custom_loading.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/widgets/password_and_email_validations.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key, required this.email});
  final String email;

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.9],
            colors: [ColorsManager.primaryLight, ColorsManager.backgroundWhite],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 60.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                color: ColorsManager.backgroundWhite,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Image.asset(
                ImageManager.authLogoIcon,
                fit: BoxFit.contain,
                width: 30.w,
                height: 30.h,
              ),
            ),
            Text(StringManager.appName, style: AppTextStyle.font32PrimaryBold),
            heightSpace(50),
            Text(
              StringManager.forgotPassword,
              style: AppTextStyle.font24BlackW700,
            ),
            heightSpace(20),
            Text(
              StringManager.forgotPasswordSubTitle1,
              style: AppTextStyle.font15GreyW500,
            ),
            Text(
              StringManager.forgotPasswordSubTitle2,
              style: AppTextStyle.font15GreyW500,
            ),
            Text(
              StringManager.forgotPasswordSubTitle3,
              style: AppTextStyle.font15GreyW500,
            ),
            heightSpace(50),
            Form(
              key: _formKey,
              child: CustomFormField(
                controller: _emailController,
                title: StringManager.email,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return StringManager.emailEmpty;
                  }
                  if (!PasswordAndEmailValidations.isValidEmail(email: email)) {
                    return StringManager.emailInvalid;
                  }
                  return null;
                },
                preIcon: Icons.email_outlined,
                hint: StringManager.emailHint,
                preIconColor: ColorsManager.primary,
              ),
            ),
            heightSpace(50),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state.status == ForgetPasswordStatus.failure) {
                  customSnackBar(
                    context: context,
                    message: state.errorMessage!,
                  );
                }
                if (state.status == ForgetPasswordStatus.success) {
                  customSnackBar(
                    context: context,
                    message: StringManager.resetPasswordSuccess,
                    isErrorMessage: false,
                  );
                }
              },
              builder: (context, state) {
                return state.status == ForgetPasswordStatus.loading
                    ? customLoading()
                    : CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ForgetPasswordCubit>().resetPassword(
                              email: _emailController.text.trim(),
                            );
                          }
                        },
                        text: StringManager.resetPassword,
                      );
              },
            ),
            heightSpace(20),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              text: StringManager.backToLogin,
            ),
          ],
        ),
      ),
    );
  }
}
