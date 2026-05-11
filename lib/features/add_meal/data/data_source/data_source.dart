import 'dart:convert';
import 'package:flutter/material.dart';
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
    } on FlutterError catch (e) {
      throw Exception("ملف البيانات غير موجود: $e");
    } on FormatException catch (e) {
      throw Exception("خطأ في تنسيق بيانات الوجبات: $e");
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: ${e.toString()}");
    }
  }
}