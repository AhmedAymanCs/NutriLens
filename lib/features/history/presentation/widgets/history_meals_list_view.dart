import 'package:flutter/material.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/history/presentation/widgets/history_meal_card.dart';

class HistoryMealsListView extends StatelessWidget {
  const HistoryMealsListView({super.key, required this.historyDataModel});

  final UserModel historyDataModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: historyDataModel.todayMeals.length,
      itemBuilder: (context, index) {
        return HistoryMealCard(meal: historyDataModel.todayMeals[index]);
      },
    );
  }
}
