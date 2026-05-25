import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/functions/get_local_session.dart';
import 'package:nutrilens/core/models/food_model.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';

abstract class AddMealRemoteDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getMealElements();

  Future<List<FoodItemModel>> getFoodItems();
  Future<void> saveMeal(FoodModel meal);
}

class AddMealRemoteDataSourceImpl implements AddMealRemoteDataSource {
  final FirebaseFirestore firestore;

  AddMealRemoteDataSourceImpl(this.firestore);

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getMealElements() async {
    final result = await firestore
        .collection(AppConstants.mealsCollectionName)
        .get();
    return result;
  }

  @override
  Future<void> saveMeal(FoodModel meal) async {
    final userSession = await getLocalUserData();
    await firestore
        .collection(AppConstants.userCollectionName)
        .doc(userSession!.uid)
        .collection(AppConstants.mealsCollectionName)
        .doc(meal.id)
        .set(meal.toJson());
  }

  @override
  Future<List<FoodItemModel>> getFoodItems() async {
    final snapshot = await firestore.collection('meals').get();
    return snapshot.docs
        .map((doc) => FoodItemModel.fromJson(doc.data()))
        .toList();
  }
}
