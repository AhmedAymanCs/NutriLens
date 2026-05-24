import 'package:nutrilens/features/add_meal/data/data_source/add_meal_data_source.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_meal_repository.dart';
import 'package:nutrilens/features/add_meal/logic/add_meal_cubit.dart';
import 'package:nutrilens/features/auth/presentation/forget_password/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/login/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/register/logic/cubit.dart';
import 'package:nutrilens/features/history/data/data_source/data_source.dart';
import 'package:nutrilens/features/history/data/repository/history_repository.dart';
import 'package:nutrilens/features/history/logic/cubit.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/repository/repositroy.dart';
import 'package:nutrilens/features/home/logic/cubit.dart';
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
import 'package:nutrilens/features/profile/presentation/logic/profile_cubit.dart';

final getIt = GetIt.instance;

void initSetupLocator() {
  _setupFirestoreServiceLocator();
  _setupSecureStorageServiceLocator();
  _setupAuthRepositoryLocator();
  _setupNotificationServiceLocator();
  _setupProfileLocator();
  _setupHomeLocator();
  _setupHistoryLocator();
  _setupAddMealLocator();
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
    () => AuthRemoteDataSourceImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  // Auth Cubits
  getIt.registerFactory(() => LoginCubit(getIt<AuthRepository>()));
  getIt.registerFactory(() => RegisterCubit());
  getIt.registerFactory(() => ForgetPasswordCubit(getIt<AuthRepository>()));
  getIt.registerFactory(() => OnboardingCubit(getIt<AuthRepository>()));
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
  getIt.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
      storage: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileDataSource>()),
  );
  getIt.registerFactory(() => ProfileCubit(getIt<ProfileRepository>()));
}

void _setupHomeLocator() {
  getIt.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      storage: getIt<SecureStorageHelper>(),
    ),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeDataSource>()),
  );

  getIt.registerFactory(() => HomeCubit(getIt<HomeRepository>()));
}

void _setupHistoryLocator() {
  getIt.registerLazySingleton<HistoryDataSource>(
    () => HistoryDataSourceImpl(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      storage: getIt<SecureStorageHelper>(),
    ),
  );

  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(
      getIt<HistoryDataSource>(),
    ),
  );

  getIt.registerFactory(() => HistoryCubit(getIt<HistoryRepository>()));
}

void _setupAddMealLocator() {
  getIt.registerLazySingleton<AddMealRemoteDataSource>(
    () => AddMealRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AddMealRepository>(
    () => AddMealRepositoryImpl(
      getIt<AddMealRemoteDataSource>(),
      getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory(() => AddMealCubit(getIt<AddMealRepository>()));
}
