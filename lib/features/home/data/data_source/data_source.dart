import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

abstract class HomeDataSource {
  Future<Map<String, dynamic>> getUserData();
  Future<List<MealModel>> getTodayMeals();
}

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  HomeDataSourceImpl({required this.firestore, required this.auth});

  @override
  Future<Map<String, dynamic>> getUserData() async {
    final uid = auth.currentUser!.uid;
    final doc = await firestore.collection('Users').doc(uid).get();
    return doc.data() ?? {};
  }

  @override
  Future<List<MealModel>> getTodayMeals() async {
    final uid = auth.currentUser!.uid;
    
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final query = await firestore
        .collection('Users')
        .doc(uid)
        .collection('meals') 
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy('timestamp', descending: true)
        .get();

    return query.docs
        .map((doc) => MealModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}