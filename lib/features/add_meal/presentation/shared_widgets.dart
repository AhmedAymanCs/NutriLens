part of 'add_screen.dart';


class _SearchBarSection extends StatelessWidget {
  final TextEditingController searchController, nameController;
  const _SearchBarSection(
      {required this.searchController, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            controller: searchController,
            onChanged: (val) => context.read<AddMealCubit>().searchMeals(val),
            decoration: InputDecoration(
              hintText: 'Search food...',
              hintStyle: AppTextStyle.font13GreyW400,
              prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 22.sp),
              suffixIcon: Padding(
                padding: EdgeInsets.all(6.h),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Icon(Icons.qr_code_scanner, size: 18.sp, color: Colors.black54),
                ),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15.h),
            ),
          ),
        ),

        BlocBuilder<AddMealCubit, AddMealState>(
          buildWhen: (prev, curr) => prev.meals != curr.meals,
          builder: (context, state) {
            if (state.meals.isEmpty) return const SizedBox();
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.meals.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final meal = state.meals[index];
                  return ListTile(
                    title: Text(meal.name, style: AppTextStyle.font11BlackW600),
                    onTap: () {
                      context.read<AddMealCubit>().selectMeal(meal);
                      nameController.text = meal.name;
                      searchController.clear();
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}


class _MealImageCard extends StatelessWidget {
  const _MealImageCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMealCubit, AddMealState>(
      buildWhen: (prev, curr) => prev.selectedMeal != curr.selectedMeal,
      builder: (context, state) {
        final meal = state.selectedMeal;
        if (meal == null) return const SizedBox();

        return Container(
          height: 200.h,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35.r),
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    child: const Icon(Icons.broken_image, size: 48),
                  ),
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Auto-detected',
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                    SizedBox(height: 4.h),
                    Text(
                      meal.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class _InputFieldsSection extends StatelessWidget {
  final TextEditingController nameController, quantityController;
  const _InputFieldsSection(
      {required this.nameController, required this.quantityController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMealCubit, AddMealState>(
      buildWhen: (prev, curr) => prev.selectedMeal != curr.selectedMeal,
      builder: (context, state) {
        if (state.selectedMeal == null) return const SizedBox();

        return Column(
          children: [
            _CustomTextField(
              label: 'Food Name',
              controller: nameController,
              readOnly: true,
            ),
            heightSpace(15),
            Row(
              children: [
                Expanded(
                  child: _CustomTextField(
                    label: 'Quantity',
                    controller: quantityController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) => context.read<AddMealCubit>().updateQuantity(val),
                  ),
                ),
                widthSpace(15),
                const Expanded(child: _UnitDropdown()),
              ],
            ),
          ],
        );
      },
    );
  }
}


class _NutritionInfoSection extends StatelessWidget {
  const _NutritionInfoSection();


  static double _macroProgress(double grams, double calsPerGram, double totalCals) {
    if (totalCals == 0) return 0;
    final ratio = (grams * calsPerGram) / totalCals;
    return ratio.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMealCubit, AddMealState>(
      builder: (context, state) {
        final meal = state.selectedMeal;
        if (meal == null) return const SizedBox(); 

        final q = state.quantity;
        final totalCal = meal.calories * q;
        final carbs   = meal.carbs   * q;
        final protein = meal.protein * q;
        final fat     = meal.fat     * q;

        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(color: ColorsManager.overlayBlack10, blurRadius: 20),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ESTIMATED NUTRITION',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(letterSpacing: 1.2),
              ),
              heightSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        totalCal.toStringAsFixed(0),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 40.sp),
                      ),
                      Text('Total Calories',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.eco, color: ColorsManager.primary, size: 28.sp),
                  ),
                ],
              ),
              heightSpace(20),
              _NutrientProgress(
                label: 'Carbs',
                value: '${carbs.toStringAsFixed(0)}g',
                progress: _macroProgress(carbs, 4, totalCal),
                color: const Color(0xFF4A6650),
              ),
              _NutrientProgress(
                label: 'Protein',
                value: '${protein.toStringAsFixed(0)}g',
                progress: _macroProgress(protein, 4, totalCal),
                color: const Color(0xFF8B4513),
              ),
              _NutrientProgress(
                label: 'Fat',
                value: '${fat.toStringAsFixed(0)}g',
                progress: _macroProgress(fat, 9, totalCal),
                color: const Color(0xFFD2691E),
              ),
            ],
          ),
        );
      },
    );
  }
}


class _ConfirmButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _ConfirmButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMealCubit, AddMealState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        final isLoading = state.status == AddMealStatus.loading;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: const BoxDecoration(
            color: ColorsManager.backgroundWhite,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              disabledBackgroundColor: Colors.grey,
              minimumSize: Size(double.infinity, 55.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                      widthSpace(10),
                      Text('Confirm Meal', style: AppTextStyle.font16WhiteWBold),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _UnitDropdown extends StatelessWidget {
  const _UnitDropdown();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Unit', style: AppTextStyle.font13GreyW400),
        heightSpace(8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: ColorsManager.background,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'Serving',
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'Serving', child: Text('Serving')),
              ],
              onChanged: (v) {},
            ),
          ),
        ),
      ],
    );
  }
}


class _NutrientProgress extends StatelessWidget {
  final String label, value;
  final double progress;
  final Color color;
  const _NutrientProgress({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyle.font11BlackW600),
              Text(value, style: AppTextStyle.font11BlackW600),
            ],
          ),
          heightSpace(8),
          LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: Colors.grey[200],
            minHeight: 6.h,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const _CustomTextField({
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.font13GreyW400),
        heightSpace(8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: AppTextStyle.font11BlackW600,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorsManager.background,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
