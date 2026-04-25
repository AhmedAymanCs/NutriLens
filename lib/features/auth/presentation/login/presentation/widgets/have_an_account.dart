import 'package:flutter/material.dart';

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
                ? "Already have an account? "
                : "Don't have an account yet? ",
            // style: AppTextStyle.font11Black600.copyWith(
            //   fontWeight: FontWeight.normal,
            // ),
          ),
          TextButton(
            // onPressed: () => context.pushNamed(AppRouter.signUpScreen),
            onPressed: () {},
            child: Text(
              haveAccount ? "Login" : "Sign up",
              // style: AppTextStyle.font13primaryColor400.copyWith(
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
