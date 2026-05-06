import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:nutrilens/core/services/local_notification_service.dart';
import 'package:nutrilens/core/services/my_bloc_observer.dart';
import 'package:nutrilens/core/theme/app_theme.dart';
import 'package:nutrilens/core/theme/cubit/cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  String? token = await FirebaseMessaging.instance.getToken();
  print("My Device Token: $token");

  Bloc.observer = MyBlocObserver();
  initSetupLocator();
  await getIt<LocalNotificationService>().init();

  await FirebaseMessaging.instance.subscribeToTopic("all_users");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(getIt<FlutterSecureStorage>()),
        ),
      ],
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
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.onGenerateRoute,
                initialRoute: Routes.profile,
              );
            },
          );
        },
      ),
    );
  }
}
