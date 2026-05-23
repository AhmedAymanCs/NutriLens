import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/features/add_meal/presentation/add_meal_screen.dart';
import 'package:nutrilens/features/history/presentation/history_screen.dart';
import 'package:nutrilens/features/home/presentation/home_screen.dart';
import 'package:nutrilens/features/profile/presentation/screens/profile_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late PageController controller;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.calendar),
      label: "History",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_circle_outline),
      label: "Add Meal",
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: "Profile",
    ),
  ];

  List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const AddMealPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: ColorsManager.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          items: items,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedIconTheme: IconThemeData(
            color: ColorsManager.background,
            size: 25.w,
          ),
          selectedItemColor: ColorsManager.background,
          selectedLabelStyle: TextStyle(
            color: ColorsManager.background,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          unselectedIconTheme: IconThemeData(
            color: ColorsManager.background,
            size: 20.w,
          ),
          unselectedItemColor: ColorsManager.background,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              // controller.jumpToPage(index);
            });
          },
        ),
      ),

      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: pages),
      ),
    );
  }
}
