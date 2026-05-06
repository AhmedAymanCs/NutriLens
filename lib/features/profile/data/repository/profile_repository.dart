


import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/profile/data/data_source/data_source.dart';
import '../models/user_model.dart';

abstract class ProfileRepository {
  ServerResponse<UserModel> getUser();
  ServerResponse<Unit> updateProfile({required UserModel user});
  ServerResponse<Unit> signOut();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  ServerResponse<UserModel> getUser() async {
    try {
      final user = await profileRemoteDataSource.getUserData();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      log("GetUser FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("GetUser Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> updateProfile({required UserModel user}) async {
    try {
      await profileRemoteDataSource.updateUserData(user: user);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("UpdateProfile FirebaseAuthException: ${e.message!}");
      return Left(e.message!);
    } catch (e) {
      log("UpdateProfile Catch: $e");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> signOut() async {
    try {
      await profileRemoteDataSource.signOut();
      return const Right(unit);
    } catch (e) {
      log("SignOut Catch: $e");
      return Left(e.toString());
    }
  }
}