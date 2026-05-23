import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/home/logic/cubit.dart';
import 'package:nutrilens/features/home/presentation/widgets/calories_summary_ring.dart';
import 'package:nutrilens/features/home/presentation/widgets/home_app_bar.dart';
import 'package:nutrilens/features/home/presentation/widgets/macros_progress_bar.dart';
import 'package:nutrilens/features/home/presentation/widgets/meals_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: const HomeAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeStatus.failure) {
            return Center(child: Text(state.errorMessage));
          }

          if (state.status == HomeStatus.success) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(24.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(20),
                  CalorieSummaryRing(
                    remaining:
                        state.homeDataModel?.dailyCalorieGoal ??
                        0 - state.homeDataModel!.dailyCalorieConsumed,
                    consumed: state.homeDataModel!.dailyCalorieConsumed,
                    goal: state.homeDataModel?.dailyCalorieGoal ?? 0,
                  ),
                  heightSpace(40),
                  MacrosProgressBar(data: state.homeDataModel!),
                  heightSpace(40),
                  Text(
                    StringManager.todaysMeals,
                    style: AppTextStyle.font18BlackBold.copyWith(
                      color: ColorsManager.textBlack,
                    ),
                  ),
                  heightSpace(16),
                  MealsListView(data: state.homeDataModel!),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
