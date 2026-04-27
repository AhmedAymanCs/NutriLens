import 'package:flutter/material.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/auth_background.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/login_logo_and_title.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/widgets/signup_card_fields.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AuthBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LoginLogoAndTitle(isRegisterPage: true),
                SignupCardFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
