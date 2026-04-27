import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(20),
            CalorieSummaryRing(
              remaining: 800,
              consumed: 1200,
              goal: 2000,
            ),
            heightSpace(40),
            const MacrosProgressBar(),
            heightSpace(40),
            Text(
              StringManager.todaysMeals,
              style: AppTextStyle.font18BlackBold.copyWith(color: ColorsManager.textBlack),
            ),
            heightSpace(16),  
            MealsListView()
          ],
        ),
      ),
    );
  }
}