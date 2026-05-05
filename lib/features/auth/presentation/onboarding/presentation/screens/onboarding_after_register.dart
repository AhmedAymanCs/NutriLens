import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/extensions/custom_extensions.dart';
import 'package:nutrilens/core/router/routes.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/custom_dots_indicator.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/custom_onboarding_button.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_age.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_gender.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_goal.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/screens/set_height_weight.dart';

class OnboardingAfterRegister extends StatefulWidget {
  const OnboardingAfterRegister({
    super.key,
    required this.registerParamsModels,
  });
  final RegisterParamsModels registerParamsModels;

  @override
  State<OnboardingAfterRegister> createState() =>
      _OnboardingAfterRegisterState();
}

class _OnboardingAfterRegisterState extends State<OnboardingAfterRegister> {
  int currentPage = 0;

  final List<Widget> pages = const [
    SetGender(),
    SetGoal(),
    SetAge(),
    SetHeightWeight(),
  ];
  PageController? _controller;

  void nextPage() {
    if (currentPage < pages.length - 1) {
      currentPage++;
      _controller!.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 600),
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
        duration: const Duration(seconds: 1),
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
                ? const SizedBox.shrink()
                : Container(
                    width: 40.r,
                    height: 40.r,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: const BoxDecoration(
                      color: ColorsManager.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: previousPage,
                      icon: const Icon(
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
          child: BlocConsumer<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state.status == OnboardingStatus.success) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              }
              if (state.status == OnboardingStatus.failure) {
                customSnackBar(context: context, message: state.errorMessage!);
                Navigator.pushReplacementNamed(context, Routes.register);
              }
            },
            builder: (context, state) {
              return Column(
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
                  CustomOnboardingButton(
                    text: currentPage == pages.length - 1
                        ? StringManager.letStartButton
                        : StringManager.continueButton,
                    onPressed:
                        context.read<OnboardingCubit>().isStepValid(
                              currentPage: currentPage,
                            ) &&
                            state.status != OnboardingStatus.loading
                        ? () {
                            currentPage == pages.length - 1
                                ? context.read<OnboardingCubit>().signUp(
                                    params: widget.registerParamsModels,
                                    userDataParams: UserOnboardingParamsModel(
                                      gender: state.selectedGender!.label,
                                      goal: state.selectedGoal!.label,
                                      age: state.selectedAgeValue!,
                                      height: state.selectedHeight!,
                                      weight: state.selectedWeight!,
                                    ),
                                  )
                                : nextPage();
                          }
                        : null,
                  ),
                  heightSpace(30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
