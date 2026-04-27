import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/custom_dots_indicator.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/custom_onboarding_button.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_age.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_gender.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_goal.dart';

class OnboardingAfterRegister extends StatefulWidget {
  const OnboardingAfterRegister({super.key});

  @override
  State<OnboardingAfterRegister> createState() =>
      _OnboardingAfterRegisterState();
}

class _OnboardingAfterRegisterState extends State<OnboardingAfterRegister> {
  int currentPage = 0;

  List<Widget> pages = [
    SetGender(onTap: () {}),
    SetGoal(
      onTapGoalLoseWeight: () {},
      onTapGoalMaintainWeight: () {},
      onTapGoalGainWeight: () {},
    ),
    SetAge(),
  ];
  PageController? _controller;

  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
      _controller!.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 600),
        curve: Curves.linear,
      );
    }
    setState(() {});
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      _controller!.animateToPage(
        currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    _controller = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundWhite,
      appBar: AppBar(
        backgroundColor: ColorsManager.backgroundWhite,
        leading: Row(
          children: [
            widthSpace(10),
            currentPage == 0
                ? SizedBox.shrink()
                : Container(
                    width: 30.r,
                    height: 30.r,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: previousPage,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ColorsManager.primary,
                        size: 20,
                      ),
                    ),
                  ),
            widthSpace(10),
            Text(
              "STEP ${currentPage + 1} OF ${pages.length}",
              style: AppTextStyle.font16PrimaryBold,
            ),
          ],
        ),
        leadingWidth: 200.w,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                  itemCount: pages.length,
                ),
              ),
              CustomDotsIndicator(
                dotsCount: pages.length,
                position: currentPage.toDouble(),
              ),
              heightSpace(20),
              CustomOnboardingButton(onPressed: nextPage),
              heightSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}
