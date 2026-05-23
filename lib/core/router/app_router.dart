import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/core/utils/custom_navigation_bar.dart';
import 'package:nutrilens/features/add_meal/presentation/logic/add_meal_cubit.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/login/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/onboarding_after_register.dart';
import 'package:nutrilens/features/auth/presentation/register/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/presentation/forget_password_screen.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/screens/login_screen.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/screens/register_screen.dart';
import 'package:nutrilens/features/history/logic/cubit.dart';
import 'package:nutrilens/features/home/logic/cubit.dart';
import 'package:nutrilens/features/home/presentation/home_screen.dart';
import 'package:nutrilens/features/profile/presentation/logic/profile_cubit.dart';
import 'package:nutrilens/features/splash/screens/splash_screen.dart';

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
      case Routes.navigationBar:
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<HomeCubit>(
                  create: (context) => getIt<HomeCubit>()..getHomeData(),
                ),
                BlocProvider<ProfileCubit>(
                  create: (context) => getIt<ProfileCubit>()..getProfileData(),
                ),
                BlocProvider<HistoryCubit>(
                  create: (context) =>
                      getIt<HistoryCubit>()..fetchHistory(DateTime.now()),
                ),
                BlocProvider<AddMealCubit>(
                  create: (context) => getIt<AddMealCubit>(),
                ),
              ],
              child: const CustomNavigationBar(),
            );
          },
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) {
            return const HomePage();
          },
        );
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) {
            return SplashScreen(
              secureStorageHelper: getIt<SecureStorageHelper>(),
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
