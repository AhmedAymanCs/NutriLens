import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';

abstract class HomeRepository {
  ServerResponse<UserModel?> getLocalUserData(); 
  ServerResponse<UserModel> getRemoteUserData();
  ServerResponse<Unit> updateUserData(UserModel user);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  ServerResponse<UserModel?> getLocalUserData() async {
    try {
      final user = await _homeDataSource.getLocalUserData();
      return Right(user);
    } catch (e) {
      return Left("Local storage error: ${e.toString()}");
    }
  }

  @override
  ServerResponse<UserModel> getRemoteUserData() async {
    try {
      final user = await _homeDataSource.getRemoteUserData();
      return Right(user);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
  
  @override
  ServerResponse<Unit> updateUserData(UserModel user) async {
    try {
      await _homeDataSource.updateUserData(user);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}