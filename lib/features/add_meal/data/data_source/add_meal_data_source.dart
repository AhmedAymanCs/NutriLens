import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';
import 'package:nutrilens/features/add_meal/data/models/save_meal_params.dart';

abstract class AddMealRemoteDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getMealElements();
  Future<void> saveMeal({required SaveMealParams params});
  Future<List<FoodItemModel>> getFoodItems();
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
  Future<void> saveMeal({required SaveMealParams params}) async {
    await firestore
        .collection(AppConstants.userCollectionName)
        .doc(params.userId)
        .collection('meals')
        .doc(params.mealModel.mealId)
        .set({'meal': params.mealModel.toJson(), 'date': params.date});
  }

  @override
  Future<List<FoodItemModel>> getFoodItems() async {
    final snapshot = await firestore.collection('meals').get();
    return snapshot.docs
        .map((doc) => FoodItemModel.fromJson(doc.data()))
        .toList();
  }
}
