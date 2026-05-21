import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HomeRepository {
  ServerResponse<UserModel> getUserData();
  ServerResponse<List<MealModel>> getTodayMeals();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  ServerResponse<UserModel> getUserData() async {
    try {
      final user = await _homeDataSource.getUserData();
      return Right(user);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }

  @override
  ServerResponse<List<MealModel>> getTodayMeals() async {
    try {
      final todayMeals = await _homeDataSource.getTodayMeals();
      return Right(todayMeals);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}