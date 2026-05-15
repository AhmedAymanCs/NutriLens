import 'package:dartz/dartz.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/history/data/data_source/data_source.dart';
import 'package:nutrilens/features/history/data/model/history_data_model.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HistoryRepository {
  ServerResponse<HistoryDataModel> getHistoryByDate(DateTime date);
}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _historyDataSource;
  final HomeDataSource _homeDataSource; 

  HistoryRepositoryImpl(this._historyDataSource, this._homeDataSource);

  @override
  ServerResponse<HistoryDataModel> getHistoryByDate(DateTime date) async {
    try {
      final results = await Future.wait([
        _homeDataSource.getUserData(), 
        _historyDataSource.getMealsByDate(date), 
      ]);

      final userData = results[0] as Map<String, dynamic>;
      final meals = results[1] as List<MealModel>;

      int consumed = 0;
      for (var meal in meals)  {
        consumed += meal.calories;
      } 

      final historyData = HistoryDataModel(
        meals: meals,
        dailyGoal: int.tryParse(userData[AppConstants.calorieKey]?.toString() ?? '0') ?? 0,
        consumedCalories: consumed,
      );

      return Right(historyData);
    } catch (e) {
      return Left("Something went wrong!");
    }
  }
}