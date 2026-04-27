import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';
import 'package:nutrilens/features/home/presentation/widgets/meal_card.dart';

class MealsListView extends StatelessWidget {
  MealsListView({super.key});

  final meals = [
    MealModel(
      title: 'Breakfast',
      description: 'Avocado Toast & Egg',
      calories: '350 kcal',
      image: ImageManager.logo,
    ),
    MealModel(
      title: 'Lunch',
      description: 'Grilled Chicken Salad',
      calories: '420 kcal',
      image: ImageManager.logo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
    
        return MealCard(
          title: meal.title,
          description: meal.description,
          calories: meal.calories,
          image: meal.image,
        );
      },
    );
  }
}