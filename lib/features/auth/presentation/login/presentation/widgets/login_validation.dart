import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/cutom_form_field.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/forgot_password.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/password_and_email_validations.dart';

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
    _loginFormKey.currentState!.dispose();
    super.dispose();
  }
  // LoginCubit cubit = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          CustomFormField(
            controller: _emailController,
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "Please enter your email";
              }
              if (!PasswordAndEmailValidations.isValidEmail(email: email)) {
                return "Please enter a valid email";
              }
              return null;
            },
            preIcon: Icons.email_outlined,
            hint: StringManager.email,
          ),
          heightSpace(20),
          CustomFormField(
            controller: _passwordController,
            obscure: true,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return "Please enter your password";
              }
              if (!PasswordAndEmailValidations.isPasswordValid(password)) {
                return "Please enter a valid password";
              }
              return null;
            },
            preIcon: Icons.visibility_off,
            hint: StringManager.password,
          ),
          const ForgotPassword(),
          heightSpace(10),
          CustomButton(
            onPressed: () {
              // LoginCubit cubit = getIt<LoginCubit>();
              if (_loginFormKey.currentState!.validate()) {
                // cubit.login(
                //   email: loginEmailController.text,
                //   password: loginPasswordController.text,
                // );
              }
            },
            text: StringManager.login,
          ),
        ],
      ),
    );
  }
}
