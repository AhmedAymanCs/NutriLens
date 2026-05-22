import 'package:dartz/dartz.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/history/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/data_source/data_source.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HistoryRepository {
  ServerResponse<UserModel> getHistoryByDate(DateTime date);
}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _historyDataSource;
  final HomeDataSource _homeDataSource;

  HistoryRepositoryImpl(this._historyDataSource, this._homeDataSource);

  @override
  ServerResponse<UserModel> getHistoryByDate(DateTime date) async {
    try {
      final results = await Future.wait([
        _homeDataSource.getUserData(),
        _historyDataSource.getMealsByDate(date),
      ]);

      final userData = results[0] as UserModel;
      final meals = results[1] as List<MealModel>;

      final historyData = userData.copyWith(todayMeals: meals);

      return Right(historyData);
    } catch (e) {
      return const Left("Something went wrong!");
    }
  }
}
