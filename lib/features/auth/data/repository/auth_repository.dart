import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/auth/data/data_source/auth_data_source.dart';

abstract class AuthRepository {
  ServerResponse<Unit> signUp({
    required String name,
    required String email,
    required String password,
  });

  ServerResponse<Unit> signIn({required String email, required String password});
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  ServerResponse<Unit> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await authRemoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      log("User: $user");
      log("User Name: ${user.user?.displayName}");
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      log("SignUp FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("SignUp Catch: $e");
      return Left(e.toString());
    }
  }
  
  @override
  ServerResponse<Unit> signIn({required String email, required String password}) async {
    try {
      await authRemoteDataSource.signIn(email: email, password: password);
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      log("SignIn FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("SignIn Catch: $e");
      return Left(e.toString());
    }
  }
}
