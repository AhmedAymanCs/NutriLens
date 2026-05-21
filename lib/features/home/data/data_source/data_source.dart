import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HomeDataSource {
  Future<UserModel> getUserData();
  Future<List<MealModel>> getTodayMeals();
}

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final SecureStorageHelper storage;

  HomeDataSourceImpl({required this.firestore, required this.auth, required this.storage});

  @override
  Future<UserModel> getUserData() async {

    final currentUserData = await storage.getData(key: AppConstants.userSession);
    Map<String, dynamic> userDataSession = jsonDecode(currentUserData!);
    return UserModel.fromFirestore(userDataSession);

  }

  @override
  Future<List<MealModel>> getTodayMeals() async {

    final userData = await storage.getData(key: AppConstants.userSession);
    Map<String, dynamic> userDataSession = jsonDecode(userData!);
    UserModel userModel = UserModel.fromFirestore(userDataSession);

    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final query = await firestore
        .collection(AppConstants.userCollectionName)
        .doc(userModel.uid)
        .collection(AppConstants.mealCollectionName) 
        .where(AppConstants.timestampKey, isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where(AppConstants.timestampKey, isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy(AppConstants.timestampKey, descending: true)
        .get();

    return query.docs
        .map((doc) => MealModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}