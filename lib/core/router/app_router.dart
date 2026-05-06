import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/features/add_meal/logic/cubit.dart';
import 'package:nutrilens/features/add_meal/presentation/add_screen.dart';
import 'package:nutrilens/features/auth/data/models/user_model.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/login/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
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
          builder: (_) {
            return BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(getIt<AuthRepository>()),
              child: const LoginPage(),
            );
          },
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(getIt<AuthRepository>()),
            child: const RegisterPage(),
          ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ForgetPasswordCubit>(
              create: (context) => ForgetPasswordCubit(getIt<AuthRepository>()),
              child: const ForgetPasswordPage(),
            );
          },
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) {
            final name = settings.arguments as String;
            return BlocProvider<OnboardingCubit>(
              create: (context) => OnboardingCubit(getIt<AuthRepository>()),
              child: OnboardingAfterRegister(userName: name),
            );
          },
        );
        // هنا هشيل الجزء ده واضيفة في الريبو وكدا كدا اليوزير مش هيرجه بنل
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) {
final userData = settings.arguments as UserDataModel?;            
            return HomePage(userModel: userData ?? UserDataModel(
                uid: '', 
                email: '', 
                name: 'User',
                age: 0,
              ),);
          },
        );
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
       case Routes.addMeals:
  return MaterialPageRoute(
    builder: (_) => BlocProvider<AddMealCubit>(
      create: (context) => getIt<AddMealCubit>(), 
      child: const AddMealScreen(),
    ),
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
