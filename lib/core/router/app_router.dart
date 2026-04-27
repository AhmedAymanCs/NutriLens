import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
import 'package:nutrilens/features/auth/presentation/login/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/onboarding_after_register.dart';
import 'package:nutrilens/features/auth/presentation/register/logic/cubit.dart';
import 'package:nutrilens/features/home/presentation/home_screen.dart';
import 'package:nutrilens/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/presentation/forget_password_screen.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/screens/login_screen.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/screens/register_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splash:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         SplashScreen(secureStorageHelper: getIt<SecureStorageHelper>()),
      //   );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(getIt<AuthRepository>()),
            child: LoginPage(),
          ),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(getIt<AuthRepository>()),
            child: RegisterPage(),
          ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingAfterRegister());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Not Found : ${settings.name}')),
          ),
        );
    }
  }
}
