import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/utils/custom_loading.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/features/auth/presentation/register/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/widgets/password_and_email_validations.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/widgets/password_validation.dart';

class SignUpValidation extends StatefulWidget {
  const SignUpValidation({super.key});

  @override
  State<SignUpValidation> createState() => _SignUpValidationState();
}

class _SignUpValidationState extends State<SignUpValidation> {
  bool hasUpperLetter = false;
  bool hasLowerLetter = false;
  bool hasANumber = false;
  bool hasSpecialCharacter = false;
  bool hasCharacterLength = false;
  bool hasMatchedPassword = false;
  // signUp Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _passwordController.addListener(() {
      setState(() {
        hasUpperLetter = PasswordAndEmailValidations.hasUpperLetter(
          _passwordController.text,
        );
        hasLowerLetter = PasswordAndEmailValidations.hasLowerLetter(
          _passwordController.text,
        );
        hasANumber = PasswordAndEmailValidations.hasANumber(
          _passwordController.text,
        );
        hasSpecialCharacter = PasswordAndEmailValidations.hasSpecialCharacter(
          _passwordController.text,
        );
        hasCharacterLength = PasswordAndEmailValidations.hasMinimumLength(
          _passwordController.text,
        );
        hasMatchedPassword = PasswordAndEmailValidations.hasMatchedPassword(
          _passwordController.text,
          _confirmPasswordController.text,
        );
      });
    });
    _confirmPasswordController.addListener(() {
      setState(() {
        hasMatchedPassword = PasswordAndEmailValidations.hasMatchedPassword(
          _passwordController.text,
          _confirmPasswordController.text,
        );
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.failure) {
            customSnackBar(context: context, message: state.errorMessage!);
          }
          if (state.status == RegisterStatus.success) {
            customSnackBar(
              context: context,
              message: "Welcome ${_nameController.text}",
              isErrorMessage: false,
            );
            Navigator.pushReplacementNamed(context, Routes.onBoarding);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              CustomFormField(
                controller: _nameController,
                validator: (userName) {
                  if (userName == null || userName.isEmpty) {
                    return StringManager.nameEmpty;
                  }
                  return null;
                },
                hint: StringManager.nameHint,
                preIcon: Icons.person_outlined,
                preIconColor: ColorsManager.primary,
              ),
              heightSpace(15),
              CustomFormField(
                controller: _emailController,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return StringManager.emailEmpty;
                  }
                  if (!PasswordAndEmailValidations.isValidEmail(email: email)) {
                    return StringManager.emailInvalid;
                  }
                  return null;
                },
                hint: StringManager.emailHint,
                preIcon: Icons.email_outlined,
                preIconColor: ColorsManager.primary,
              ),
              heightSpace(15),
              CustomFormField(
                controller: _passwordController,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return StringManager.passwordEmpty;
                  }
                  if (!PasswordAndEmailValidations.isPasswordValid(password)) {
                    return StringManager.passwordInvalid;
                  }
                  return null;
                },
                obscure: !state.passwordObscure,
                onPressed: () {
                  context.read<RegisterCubit>().changePasswordVisible();
                },
                hint: StringManager.passwordHint,
                preIcon: Icons.lock_outline,
                preIconColor: ColorsManager.primary,
              ),
              heightSpace(15),
              CustomFormField(
                controller: _confirmPasswordController,
                validator: (confirmPassword) {
                  if (confirmPassword == null || confirmPassword.isEmpty) {
                    return StringManager.passwordEmpty;
                  }
                  if (!PasswordAndEmailValidations.hasMatchedPassword(
                    _passwordController.text,
                    confirmPassword,
                  )) {
                    return StringManager.passwordNotMatch;
                  }
                  return null;
                },
                obscure: !state.confirmPasswordObscure,
                onPressed: () {
                  context.read<RegisterCubit>().changeConfirmPasswordVisible();
                },
                hint: StringManager.confirmPasswordHint,
                preIcon: Icons.lock_outline,
                preIconColor: ColorsManager.primary,
              ),
              heightSpace(15),
              PasswordValidation(
                hasANumber: hasANumber,
                hasCharacterLength: hasCharacterLength,
                hasLowerLetter: hasLowerLetter,
                hasSpecialCharacter: hasSpecialCharacter,
                hasUpperLetter: hasUpperLetter,
                isSignUpScreen: true,
                hasMatchedPassword: hasMatchedPassword,
              ),
              heightSpace(10),
              state.status == RegisterStatus.loading
                  ? customLoading()
                  : CustomButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.onBoarding,
                        );
                        // if (_formKey.currentState!.validate()) {
                        //   context.read<RegisterCubit>().signUp(
                        //     email: _emailController.text,
                        //     password: _passwordController.text,
                        //     name: _nameController.text,
                        //   );
                        // }
                      },
                      text: StringManager.signUp,
                    ),
            ],
          );
        },
      ),
    );
  }
}
