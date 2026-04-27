import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/router/routes.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key, this.haveAccount = false});
  final bool haveAccount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            haveAccount
                ? StringManager.alreadyHaveAccount
                : StringManager.dontHaveAccount,
          ),
          TextButton(
            onPressed: () => haveAccount
                ? Navigator.of(context).pop()
                : Navigator.of(context).pushNamed(Routes.register),
            child: Text(
              haveAccount ? StringManager.login : StringManager.signUp,
            ),
          ),
        ],
      ),
    );
  }
}
