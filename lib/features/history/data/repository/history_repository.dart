import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/history/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HistoryRepository {
  ServerResponse<UserModel> getUserData();
  ServerResponse<List<MealModel>> getHistoryByDate(DateTime date);
}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _historyDataSource;

  HistoryRepositoryImpl(this._historyDataSource);

  @override
  ServerResponse<UserModel> getUserData() async {
    try {
      final user = await _historyDataSource.getUserData();
      return Right(user);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  ServerResponse<List<MealModel>> getHistoryByDate(DateTime date) async {
    try {
      final meals = await _historyDataSource.getMealsByDate(date);
      return Right(meals);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}