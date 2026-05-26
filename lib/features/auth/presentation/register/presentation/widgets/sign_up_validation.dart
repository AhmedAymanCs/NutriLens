import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';
import 'package:nutrilens/features/auth/presentation/register/logic/cubit.dart';

class SignUpValidation extends StatefulWidget {
  const SignUpValidation({super.key});

  @override
  State<SignUpValidation> createState() => _SignUpValidationState();
}

class _SignUpValidationState extends State<SignUpValidation> {
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
      child: BlocBuilder<RegisterCubit, RegisterState>(
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
                  if (password == null || password.trim().isEmpty) {
                    return StringManager.passwordEmpty;
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
                  if (confirmPassword == null ||
                      confirmPassword.trim().isEmpty) {
                    return StringManager.passwordEmpty;
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
              heightSpace(10),
              CustomButton(
                onPressed: () {
                  if (_passwordController.text.trim() !=
                      _confirmPasswordController.text.trim()) {
                    customSnackBar(
                      context: context,
                      message: StringManager.passwordNotMatch,
                    );
                    return;
                  }
                  RegisterParamsModels params = RegisterParamsModels(
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  if (_formKey.currentState!.validate()) {
                    customSnackBar(
                      context: context,
                      message: "Welcome ${params.name}",
                      isErrorMessage: false,
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.onBoarding,
                      arguments: params,
                    );
                  }
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
