import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/presentation/forget_password_screen.dart';
import 'package:nutrilens/features/auth/presentation/login/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/onboarding_after_register.dart';
import 'package:nutrilens/features/auth/presentation/register/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/screens/register_screen.dart';
import 'package:nutrilens/features/history/presentation/history_screen.dart';
import 'package:nutrilens/features/home/presentation/home_screen.dart';
import 'package:nutrilens/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/login_screen.dart';

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
            create: (context) => getIt<LoginCubit>(),
            child: const LoginPage(),
          ),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterCubit>(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterPage(),
          ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) {
            String email = settings.arguments as String;
            return BlocProvider<ForgetPasswordCubit>(
              create: (context) => getIt<ForgetPasswordCubit>(),
              child: ForgetPasswordPage(email: email),
            );
          },
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) {
          // UserModel userModel = settings.arguments as UserModel;
          return HomePage();
        });
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case Routes.history:
        return MaterialPageRoute(builder: (_) => HistoryPage());
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) {
            RegisterParamsModels registerParamsModels =
                settings.arguments as RegisterParamsModels;
            return BlocProvider<OnboardingCubit>(
              create: (context) => getIt<OnboardingCubit>(),
              child: OnboardingAfterRegister(
                registerParamsModels: registerParamsModels,
              ),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Not Found : ${settings.name}')),
          ),
        );
    }
  }
}
