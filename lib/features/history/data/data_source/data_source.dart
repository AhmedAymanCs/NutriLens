import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HistoryDataSource {
  Future<List<MealModel>> getMealsByDate(DateTime date);
}

class HistoryDataSourceImpl implements HistoryDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final SecureStorageHelper storage;

  HistoryDataSourceImpl({
    required this.firestore,
    required this.auth,
    required this.storage,
  });

  @override
  Future<List<MealModel>> getMealsByDate(DateTime date) async {
    final userData = await storage.getData(key: AppConstants.userSession);

    Map<String, dynamic> userDataSession = jsonDecode(userData!);
    String uid = userDataSession['uid'];

    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = await firestore
        .collection(AppConstants.userCollectionName)
        .doc(uid)
        .collection(AppConstants.mealsCollectionName)
        .where(
          AppConstants.timestampKey,
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where(
          AppConstants.timestampKey,
          isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
        )
        .orderBy(AppConstants.timestampKey, descending: true)
        .get();

    return query.docs
        .map((doc) => MealModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}
