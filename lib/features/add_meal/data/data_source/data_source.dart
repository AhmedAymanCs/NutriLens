import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';

abstract class AddMealLocalDataSource {
  Future<List<MealModel>> getMealsFromAssets();
}

class AddMealLocalDataSourceImpl implements AddMealLocalDataSource {
  @override
  Future<List<MealModel>> getMealsFromAssets() async {
    try {
      final String response = await rootBundle.loadString('assets/data/meals.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => MealModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("حدث خطأ أثناء تحميل البيانات المحلية");
    }
  }
}