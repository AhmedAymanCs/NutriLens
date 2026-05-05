import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/history/data/model/history_data_model.dart';
import 'package:nutrilens/features/history/logic/cubit.dart';
import 'package:nutrilens/features/history/logic/state.dart';
import 'package:nutrilens/features/history/presentation/widgets/custom_calendar.dart';
import 'package:nutrilens/features/history/presentation/widgets/daily_intake_card.dart';
import 'package:nutrilens/features/history/presentation/widgets/history_header.dart';
import 'package:nutrilens/features/history/presentation/widgets/history_meals_list_view.dart';
import 'package:nutrilens/features/history/presentation/widgets/meals_filter.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';
part 'shared_widgets.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final dummyData = HistoryDataModel(
    dailyGoal: 2000,
    consumedCalories: 570,
    meals: [
      MealModel(
        id: '1',
        foodName: 'Avocado Toast',
        mealType: 'Breakfast',
        timestamp: DateTime(2026, 5, 5),
        quantity: 300,
        unit: 'g',
        calories: 320,
        carbs: 20,
        protein: 10,
        fat: 15,
        isEaten: true,
        imageUrl: ImageManager.logo,
      ),
      MealModel(
        id: '2',
        foodName: 'Chicken Salad',
        mealType: 'Lunch',
        timestamp: DateTime(2026, 5, 5),
        quantity: 100,
        unit: 'g',
        calories: 450,
        carbs: 20,
        protein: 10,
        fat: 15,
        isEaten: false,
        imageUrl: ImageManager.logo,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HistoryCubit>(),
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state.status == HistoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
      
            if (state.status == HistoryStatus.failure) {
              return Center(
                child: Text(state.error),
              );
            }
      
            if (state.status == HistoryStatus.success || state.status == HistoryStatus.initial) {
              return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  heightSpace(32),
                  HistoryHeader(),
                  heightSpace(16),
                  CustomCalendar(
                    selectedDay: state.focusedDay,
                    onDaySelected: (focusedDay) {
                      
                    },
                  ),
                  heightSpace(24),
      
                  DailyIntakeCard(
                    consumed: dummyData.consumedCalories,
                    goal: dummyData.dailyGoal,
                  ),
      
                  heightSpace(24),
                  MealFilters(
                    selectedFilter: state.selectedFilter,
                    onFilterChanged: (filter) {
                      context.read<HistoryCubit>().updateFilter(filter);
                    },
                  ),
      
                  heightSpace(8),
                  HistoryMealsListView(historyDataModel: dummyData),
                ],
              ),
            );
            
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
