import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/history/data/data_source/data_source.dart';

abstract class HistoryRepository {
  ServerResponse<UserModel?> getLocalUserData();
  ServerResponse<UserModel> getRemoteHistoryData(DateTime date);
}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _historyDataSource;

  HistoryRepositoryImpl(this._historyDataSource);

  @override
  ServerResponse<UserModel?> getLocalUserData() async {
    try {
      final user = await _historyDataSource.getLocalUserData();
      return Right(user);
    } catch (e) {
      return Left("Local storage error: ${e.toString()}");
    }
  }

  @override
  ServerResponse<UserModel> getRemoteHistoryData(DateTime date) async {
    try {
      final data = await _historyDataSource.getRemoteHistoryData(date);
      return Right(data);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}