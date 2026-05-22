import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HistoryDataSource {
  Future<UserModel?> getLocalUserData();
  Future<UserModel> getRemoteHistoryData(DateTime date);
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
  Future<UserModel?> getLocalUserData() async {
    final currentUserData = await storage.getData(key: AppConstants.userSession);    
    Map<String, dynamic> userDataSession = jsonDecode(currentUserData!);
    return UserModel.fromFirestore(userDataSession);
  }

  @override
  Future<UserModel> getRemoteHistoryData(DateTime date) async {
    
    final currentUid = auth.currentUser!.uid;
    final userDoc = await firestore.collection(AppConstants.userCollectionName).doc(currentUid).get();
    
    UserModel user = UserModel.fromFirestore(userDoc.data()!);

    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = await firestore
        .collection(AppConstants.userCollectionName)
        .doc(currentUid)
        .collection(AppConstants.mealCollectionName) 
        .where(AppConstants.timestampKey, isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where(AppConstants.timestampKey, isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy(AppConstants.timestampKey, descending: true)
        .get();
   
    List<MealModel> historyMeals = query.docs
        .map((doc) => MealModel.fromFirestore(doc.data(), doc.id))
        .toList();

    return user.copyWith(
      todayMeals: historyMeals,
    );
  }
}