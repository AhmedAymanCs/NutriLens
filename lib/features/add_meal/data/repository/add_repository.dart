import 'package:dartz/dartz.dart';
import 'package:nutrilens/features/add_meal/data/data_source/data_source.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';

typedef ServerResponse<T> = Future<Either<String, T>>;

abstract class AddMealRepository {
  ServerResponse<List<MealModel>> searchMeals(String query);
  ServerResponse<void> addMeal(MealModel meal); 
}

class AddMealRepositoryImpl implements AddMealRepository {
  final AddMealLocalDataSource localDataSource;

  AddMealRepositoryImpl(this.localDataSource);

  @override
  ServerResponse<List<MealModel>> searchMeals(String query) async {
    try {
      final allMeals = await localDataSource.getMealsFromAssets();
      if (query.isEmpty) return Right(allMeals);
      
      final filtered = allMeals.where((meal) => 
        meal.name.toLowerCase().contains(query.toLowerCase())).toList();
      
      return Right(filtered);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<void> addMeal(MealModel meal) async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}