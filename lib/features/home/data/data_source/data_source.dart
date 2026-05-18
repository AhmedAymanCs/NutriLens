import 'dart:convert';
import 'dart:developer';

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
    final uid = auth.currentUser!.uid;
    // final uid = "cezwhJQagQOmscxfWBazANgPeeW2";
    final doc = await firestore.collection(AppConstants.userCollectionName).doc(uid).get();
    final userData = await storage.getData(key: AppConstants.userSession);
    final userDataSession = jsonDecode(userData!);
    log(userDataSession);
    return UserModel.fromFirestore(doc.data()!);
  }

  @override
  Future<List<MealModel>> getTodayMeals() async {
    // final uid = "cezwhJQagQOmscxfWBazANgPeeW2";
    final userData = await storage.getData(key: AppConstants.userSession);
    final userDataSession = jsonDecode(userData!);
    log(userDataSession);
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final query = await firestore
        .collection(AppConstants.userCollectionName)
        // .doc(uid)
        // .collection(AppConstants.mealCollectionName) 
        // .where(AppConstants.timestampKey, isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        // .where(AppConstants.timestampKey, isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        // .orderBy(AppConstants.timestampKey, descending: true)
        .get();
    var x = query.docs
        .map((doc) {
           log(doc.data().toString());
           print(333333);
          return MealModel.fromFirestore(doc.data(), doc.id);
        } )
        .toList();
   
  return x;
    // return query.docs
    //     .map((doc) => MealModel.fromFirestore(doc.data(), doc.id))
    //     .toList();
  }
}