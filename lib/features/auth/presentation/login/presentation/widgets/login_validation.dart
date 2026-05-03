import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/utils/custom_loading.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/features/auth/presentation/login/logic/cubit.dart';

class LoginValidation extends StatefulWidget {
  const LoginValidation({super.key});

  @override
  State<LoginValidation> createState() => _LoginValidationState();
}

class _LoginValidationState extends State<LoginValidation> {
  // login Controllers
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    return Form(
      key: _loginFormKey,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            customSnackBar(context: context, message: state.errorMessage);
          }
          if (state.status == LoginStatus.success) {
            customSnackBar(
              context: context,
              message: StringManager.loginSuccess,
              isErrorMessage: false,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
              arguments: state.userModel,
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              CustomFormField(
                controller: _emailController,
                title: StringManager.email,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return StringManager.emailEmpty;
                  }
                  return null;
                },
                preIcon: Icons.email_outlined,
                hint: StringManager.emailHint,
                preIconColor: ColorsManager.primary,
              ),
              heightSpace(20),
              CustomFormField(
                controller: _passwordController,
                title: StringManager.password,
                obscure: !state.passwordObscure,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return StringManager.passwordEmpty;
                  }
                  return null;
                },
                preIcon: Icons.lock_outlined,
                preIconColor: ColorsManager.primary,
                hint: StringManager.passwordHint,
                onPressed: () =>
                    context.read<LoginCubit>().changePasswordVisible(),
              ),

              SizedBox(
                width: deviceWidth * 0.75,
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: const Offset(-4, 0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: state.rememberMe,
                            side: const BorderSide(
                              color: ColorsManager.primary,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) =>
                                context.read<LoginCubit>().changeRememberMe(),
                          ),

                          Text(
                            StringManager.rememberMe,
                            style: AppTextStyle.font13GreyW400,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.forgetPassword,
                        arguments: _emailController.text.trim(),
                      ),
                      child: Text(
                        StringManager.forgotPassword,
                        style: AppTextStyle.font13GreyW400,
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(10),
              state.status == LoginStatus.loading
                  ? customLoading()
                  : CustomButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(Routes.onBoarding);
                        if (_loginFormKey.currentState!.validate()) {
                          context.read<LoginCubit>().signIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            rememberMe: state.rememberMe,
                          );
                        }
                      },
                      text: StringManager.login,
                    ),
            ],
          );
        },
      ),
    );
  }
}
