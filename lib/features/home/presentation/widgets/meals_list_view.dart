import 'package:flutter/material.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/home/presentation/widgets/meal_card.dart';

class MealsListView extends StatelessWidget {
  const MealsListView({super.key, required this.data});

  final UserModel data;
  // final meals = [
  //   MealModel(
  //     title: 'Breakfast',
  //     description: 'Avocado Toast & Egg',
  //     calories: '350 kcal',
  //     image: ImageManager.logo,
  //   ),
  //   MealModel(
  //     title: 'Lunch',
  //     description: 'Grilled Chicken Salad',
  //     calories: '420 kcal',
  //     image: ImageManager.logo,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.todayMeals.length,
      itemBuilder: (context, index) {
        return MealCard(mealModel: data.todayMeals[index]);
      },
    );
  }
}
