import 'package:flutter/material.dart';

import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/auth_background.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/login_card_fields.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/login_logo_and_title.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AuthBackground(
          child: SingleChildScrollView(
            child: Column(children: [LoginLogoAndTitle(), LoginCardFields()]),
          ),
        ),
      ),
    );
  }
}
