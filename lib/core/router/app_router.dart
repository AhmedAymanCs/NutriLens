import 'package:nutrilens/features/history/presentation/history_screen.dart';
import 'package:nutrilens/features/home/presentation/home_screen.dart';
import 'package:nutrilens/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/features/auth/presentation/forget_passoword/presentation/forget_password_screen.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/login_screen.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/register_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splash:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         SplashScreen(secureStorageHelper: getIt<SecureStorageHelper>()),
      //   );
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case Routes.history:
        return MaterialPageRoute(builder: (_) => HistoryPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Not Found : ${settings.name}')),
          ),
        );
    }
  }
}
