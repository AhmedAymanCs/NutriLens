import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrilens/core/config/firebase_options.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/core/router/app_router.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/services/my_bloc_observer.dart';
import 'package:nutrilens/core/theme/app_theme.dart';
import 'package:nutrilens/core/theme/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);
  Bloc.observer = MyBlocObserver();
  initSetupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(getIt<FlutterSecureStorage>()),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) {
              return MaterialApp(
                title: StringManager.appName,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.lightTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.onGenerateRoute,
                initialRoute: Routes.login,
              );
            },
          );
        },
      ),
    );
  }
}



/*
m1@email.com
123456789Mm#
 */
