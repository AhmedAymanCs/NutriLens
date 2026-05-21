import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/features/add_meal/data/models/save_meal_params.dart';

abstract class AddMealRemoteDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getMealElements();
  Future<void> saveMeal({required SaveMealParams params});
}

class AddMealRemoteDataSourceImpl implements AddMealRemoteDataSource {
  final FirebaseFirestore firestore;

  AddMealRemoteDataSourceImpl(this.firestore);

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getMealElements() async {
    final result = await firestore
        .collection(AppConstants.mealCollectionName)
        .get();
    return result;
  }

  @override
  Future<void> saveMeal({required SaveMealParams params}) async {
    await firestore
        .collection(AppConstants.userCollectionName)
        .doc(params.userId)
        .update({
          'meals': FieldValue.arrayUnion([
            {
              'meal': params.mealModel
                  .copyWith(mealType: params.mealType, mealId: params.userId)
                  .toJson(),
              'date': params.date,
            },
          ]),
        });
  }
}
