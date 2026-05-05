import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime selectedDay;
  final Function(DateTime) onDaySelected;

  const CustomCalendar({
    super.key, 
    required this.selectedDay, 
    required this.onDaySelected
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.gray500,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: selectedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: (selected, focused) {
          if (!isSameDay(selectedDay, selected)) {
            onDaySelected(selected); 
          }
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        headerVisible: true,
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: ColorsManager.primary, 
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: ColorsManager.primary.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: AppTextStyle.font15GreyW500,
          weekendTextStyle: AppTextStyle.font15GreyW500,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppTextStyle.font13GreyW400,
          weekendStyle: AppTextStyle.font13GreyW400,
        ),
        
        availableGestures: AvailableGestures.all,
        calendarFormat: CalendarFormat.month,
      ),
    );
  }
}