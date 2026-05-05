import 'package:flutter/material.dart';
import 'package:nutrilens/features/history/data/model/history_data_model.dart';
import 'package:nutrilens/features/history/presentation/widgets/history_meal_card.dart';

class HistoryMealsListView extends StatelessWidget {
  const HistoryMealsListView({super.key, required this.historyDataModel});

  final HistoryDataModel historyDataModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: historyDataModel.meals.length,
      itemBuilder: (context, index) {
        return HistoryMealCard(meal: historyDataModel.meals[index]);
      },
    );
  }
}
