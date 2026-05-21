import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/home/logic/cubit.dart';
import 'package:nutrilens/features/home/presentation/widgets/calories_summary_ring.dart';
import 'package:nutrilens/features/home/presentation/widgets/home_app_bar.dart';
import 'package:nutrilens/features/home/presentation/widgets/macros_progress_bar.dart';
import 'package:nutrilens/features/home/presentation/widgets/meals_list_view.dart';

class HomePage extends StatelessWidget {
  final UserModel userModel;
  const HomePage({super.key, required this.userModel});

//   final dummyData = HomeDataModel(
//   calorieGoal: 2000,
//   consumedCalories: 1200,
//   proteinGoal: 150,
//   proteinConsumed: 90,
//   carbsGoal: 250,
//   carbsConsumed: 180,
//   fatsGoal: 70,
//   fatsConsumed: 45,
//   todayMeals: [
//     MealModel(
//       id: 'm1',
//       foodName: 'Avocado Toast & Egg',
//       mealType: 'Breakfast',
//       isEaten: true,
//       quantity: 250,
//       unit: 'g',
//       calories: 350,
//       carbs: 45,
//       protein: 12,
//       fat: 8,
//       imageUrl: ImageManager.logo,
//       timestamp: DateTime.now().subtract(const Duration(hours: 4)),
//     ),
//     MealModel(
//       id: 'm2',
//       foodName: 'Grilled Chicken Salad',
//       mealType: 'Lunch',
//       isEaten: true,
//       quantity: 200,
//       unit: 'g',
//       calories: 600,
//       carbs: 10,
//       protein: 45,
//       fat: 15,
//       imageUrl: ImageManager.logo,
//       timestamp: DateTime.now().subtract(const Duration(hours: 1)),
//     ),
    
//   ],
// );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getUserData()..getTodayMeals(),
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        appBar: const HomeAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeStatus.failure) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            if (state.status == HomeStatus.success) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(24.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpace(20),
                    CalorieSummaryRing(
                      remaining: (state.userModel?.dailyCalorieGoal ?? 0) - state.userModel!.dailyCalorieConsumed,
                      consumed: state.userModel!.dailyCalorieConsumed,
                      goal: state.userModel?.dailyCalorieGoal ?? 0,
                    ),
                    heightSpace(40),
                    MacrosProgressBar(data: state.userModel!),
                    heightSpace(40),
                    Text(
                      StringManager.todaysMeals,
                      style: AppTextStyle.font18BlackBold.copyWith(
                        color: ColorsManager.textBlack,
                      ),
                    ),
                    heightSpace(16),
                    MealsListView(
                      data: state.mealModels ?? [],
                    ),
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
