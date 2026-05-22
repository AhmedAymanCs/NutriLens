import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/profile/data/data_source/data_source.dart';

abstract class ProfileRepository {
  ServerResponse<Unit> editProfile(UserModel user);
  ServerResponse<Unit> logout();
  ServerResponse<UserModel> getUserProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  ServerResponse<Unit> editProfile(UserModel user) async {
    try {
      await _dataSource.editProfile(user);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("Edit profile FirebaseAuthException ${e.message}");
      return Left(e.message!);
    } catch (e) {
      log("Edit profile Catch error ${e.toString()}");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<UserModel> getUserProfile() async {
    try {
      final user = await _dataSource.getUserProfile();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      log("Edit profile FirebaseAuthException ${e.message}");
      return Left(e.message!);
    } catch (e) {
      log("Edit profile Catch error ${e.toString()}");
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> logout() async {
    try {
      await _dataSource.logout();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log("Logout FirebaseAuthException ${e.message}");
      return Left(e.message!);
    } catch (e) {
      log("Logout Catch error ${e.toString()}");
      return Left(e.toString());
    }
  }
}
