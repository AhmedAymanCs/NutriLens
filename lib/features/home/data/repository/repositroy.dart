import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/model/home_data_model.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HomeRepository {
  ServerResponse<HomeDataModel> getHomeData();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  ServerResponse<HomeDataModel> getHomeData() async {
    try {
      final results = await Future.wait([
        _homeDataSource.getUserData(),
        _homeDataSource.getTodayMeals(),
      ]);

      final userData = results[0] as Map<String, dynamic>;
      final todayMeals = results[1] as List<MealModel>;

      int consumedCals = 0;
      int consumedProtein = 0;
      int consumedCarbs = 0;
      int consumedFats = 0;

      for (var meal in todayMeals) {
        consumedCals += meal.calories;
        consumedProtein += meal.protein;
        consumedCarbs += meal.carbs;
        consumedFats += meal.fat;
      }

      final homeData = HomeDataModel(
        calorieGoal:
            int.tryParse(userData[AppConstants.dailyCalorieGoalKey]?.toString() ?? '0') ??
            0,
        proteinGoal:
            int.tryParse(userData[AppConstants.proteinKey]?.toString() ?? '0') ?? 0,
        carbsGoal: int.tryParse(userData[AppConstants.carbsKey]?.toString() ?? '0') ?? 0,
        fatsGoal: int.tryParse(userData[AppConstants.fatKey]?.toString() ?? '0') ?? 0,
        consumedCalories: consumedCals,
        proteinConsumed: consumedProtein,
        carbsConsumed: consumedCarbs,
        fatsConsumed: consumedFats,
        todayMeals: todayMeals,
      );

      return Right(homeData);
    } on FirebaseException catch (e) {
      return Left(e.message ?? "Firebase exception");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}
