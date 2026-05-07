import 'package:dio/dio.dart';
import 'package:nutrilens/features/add_meal/data/data_source/data_source.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_repository.dart';
import 'package:nutrilens/features/add_meal/logic/cubit.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/repository/repositroy.dart';
import 'package:nutrilens/features/profile/data/data_source/data_source.dart';
import 'package:nutrilens/features/profile/data/repository/profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrilens/core/services/local_notification_service.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/features/auth/data/data_source/auth_data_source.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
import 'package:nutrilens/features/profile/logic/cubit.dart';

final getIt = GetIt.instance;

void initSetupLocator() {
  _setupFirestoreServiceLocator();
  _setupSecureStorageServiceLocator();
  _setupAuthRepositoryLocator();
  _setupNotificationServiceLocator();
  _setupProfileLocator();
  _setupHomeLocator();
  _setupAddMealLocator();
  // getIt.registerLazySingleton<NotificationCubit>(() => NotificationCubit());
}

void _setupSecureStorageServiceLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );
  getIt.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(getIt<FlutterSecureStorage>()),
  );
}

void _setupAuthRepositoryLocator() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
      getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
}

void _setupFirestoreServiceLocator() {
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}

void _setupNotificationServiceLocator() {
  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );
  getIt.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(getIt<FlutterLocalNotificationsPlugin>()),
  );
  getIt<LocalNotificationService>().init();
}

void _setupProfileLocator() {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
      getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
  );

  getIt.registerFactory(() => ProfileCubit(getIt<ProfileRepository>()));
}

void _setupHomeLocator() {
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeDataSource>()),
  );
}

void _setupAddMealLocator() {
  getIt.registerLazySingleton<AddMealLocalDataSource>(
    () => AddMealLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<AddMealRepository>(
    () => AddMealRepositoryImpl(getIt<AddMealLocalDataSource>()),
  );

  getIt.registerFactory(() => AddMealCubit(getIt<AddMealRepository>()));
}
