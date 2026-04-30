import 'package:dartz/dartz.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';
import '../data_source/data_source.dart';

abstract class AddMealRepository {
  Future<Either<String, void>> addMeal(MealModel meal);
  Future<Either<String, List<MealModel>>> getMeals();
  Future<Either<String, List<MealModel>>> searchMeals(String query);
}

class AddMealRepositoryImpl implements AddMealRepository {
  final AddMealRemoteDataSource remoteDataSource;

  AddMealRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> addMeal(MealModel meal) async {
    try {
      await remoteDataSource.addMeal(meal);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MealModel>>> getMeals() async {
    try {
      final meals = await remoteDataSource.getMeals();
      return Right(meals);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MealModel>>> searchMeals(String query) async {
    try {
      final searchResults = await remoteDataSource.searchMeals(query);
      return Right(searchResults);
    } catch (e) {
      return Left(e.toString());
    }
  }
}