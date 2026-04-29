import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/auth/data/data_source/auth_data_source.dart';
import 'package:nutrilens/features/auth/data/models/user_model.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';

abstract class AuthRepository {
  ServerResponse<Unit> signIn({
    required String email,
    required String password,
  });

  ServerResponse<Unit> signUp({
    required String name,
    required String email,
    required String password,
  });

  ServerResponse<Unit> addDataToFirestore({
    required OnboardingState state,
    required String name,
  });
  ServerResponse<UserDataModel> addUserSession({
    required UserDataModel userModel,
  });

  ServerResponse<UserDataModel> getUserSession();

  ServerResponse<Unit> resetPassword({required String email});
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  ServerResponse<Unit> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.signIn(email: email, password: password);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("SignIn FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("SignIn Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("SignUp FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("SignUp Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> addDataToFirestore({
    required OnboardingState state,
    required String name,
  }) async {
    try {
      await authRemoteDataSource.addDataToFirestore(state: state, name: name);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("AddDataToFirestore FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("AddDataToFirestore Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<UserDataModel> addUserSession({
    required UserDataModel userModel,
  }) async {
    try {
      await authRemoteDataSource.addUserSession(userModel: userModel);
      return Right(userModel);
    } on Exception catch (e) {
      log("AddUserSession Exception: $e");
      return Left(e.toString());
    } catch (e) {
      log("AddUserSession Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> resetPassword({required String email}) async {
    try {
      await authRemoteDataSource.resetPassword(email: email);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("resetPassword FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("resetPassword Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<UserDataModel> getUserSession() async {
    try {
      UserDataModel userModel = await authRemoteDataSource.getUserSession();
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      log("getUserSession FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("getUserSession Catch: $e");
      return Left(e.toString());
    }
  }
}
