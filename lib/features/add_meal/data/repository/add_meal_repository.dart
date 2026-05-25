import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/add_meal/data/data_source/add_meal_data_source.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';
import 'package:nutrilens/features/add_meal/data/models/save_meal_params.dart';

abstract class AddMealRepository {
  ServerResponse<List<MealModel>> getMealElements();
  ServerResponse<Unit> saveMeal({
    required MealModel mealModel,
    required String mealType,
  });
  ServerResponse<List<FoodItemModel>> getFoodItems();
}

class AddMealRepositoryImpl implements AddMealRepository {
  final AddMealRemoteDataSource addMealLocalDataSource;
  final SecureStorageHelper storage;

  AddMealRepositoryImpl(this.addMealLocalDataSource, this.storage);

  @override
  ServerResponse<List<MealModel>> getMealElements() async {
    try {
      final result = await addMealLocalDataSource.getMealElements();
      if (result.docs.isNotEmpty) {
        List<MealModel> meals = [];
        for (var meal in result.docs) {
          meals.add(MealModel.fromJson(meal.data()));
        }
        log('in getMeals() ==> meals: $meals');
        return Right(meals);
      }
      return const Left('No meals found');
    } on FirebaseException catch (e) {
      log('in getMeals() FirebaseException: ${e.message}');
      return Left(e.message!);
    } catch (e) {
      log('in getMeals() catch: $e');
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> saveMeal({
    required MealModel mealModel,
    required String mealType,
  }) async {
    try {
      final userData = await storage.getData(key: AppConstants.userTempSession);
      Map<String, dynamic> userDataJson = jsonDecode(userData!);
      String userId = userDataJson["uid"];
      DateTime dateTime = DateTime.now();
      DateFormat format = DateFormat(AppConstants.dateTimeFormat);
      String formattedString = format.format(dateTime);
      DateTime formattedDate = format.parse(formattedString);
      await addMealLocalDataSource
          .saveMeal(
            params: SaveMealParams(
              mealModel: mealModel,
              userId: userId,
              mealType: mealType,
              date: formattedDate,
            ),
          )
          .then((value) {
            log('Meal saved successfully');
          })
          .catchError((e) {
            log('Error saving meal: $e');
          });
      return right(unit);
    } on FirebaseException catch (e) {
      log('in saveMeal() FirebaseException: ${e.message}');
      return Left(e.message!);
    } catch (e) {
      log('in saveMeal() catch: $e');
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<List<FoodItemModel>> getFoodItems() async {
    try {
      final result = await addMealLocalDataSource.getFoodItems();
      return Right(result);
    } on FirebaseException catch (e) {
      log('in Get Food Items FirebaseException: ${e.message}');
      return Left(e.message!);
    } catch (e) {
      log('in Get Food Items catch: $e');
      return Left(e.toString());
    }
  }
}
