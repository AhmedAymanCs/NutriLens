import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';

class MealFilters extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const MealFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final List<String> filters = const [
    StringManager.allMeals,
    StringManager.breakfast,
    StringManager.lunch,
    StringManager.dinner,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((filter) {
          bool isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () => onFilterChanged(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorsManager.primary.withValues(alpha: 0.4)
                      : ColorsManager.gray200,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: isSelected
                        ? ColorsManager.primary
                        : ColorsManager.gray200,
                  ),
                ),
                child: Text(
                  filter,
                  style: isSelected ? AppTextStyle.font13primaryColorW400 : AppTextStyle.font13primaryColorW400.copyWith(color: ColorsManager.gray500)
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
