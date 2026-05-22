import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HomeRepository {
  ServerResponse<UserModel> getHomeData();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  ServerResponse<UserModel> getHomeData() async {
    try {
      final results = await Future.wait([
        _homeDataSource.getUserData(),
        _homeDataSource.getTodayMeals(),
      ]);

      final user = results[0] as UserModel;
      final todayMeals = results[1] as List<MealModel>;

      final homeUserData = user.copyWith(todayMeals: todayMeals);

      return Right(homeUserData);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}
