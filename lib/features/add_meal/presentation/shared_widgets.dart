part of 'add_screen.dart';

class _AddMealBody extends StatelessWidget {
  final TextEditingController nameController, quantityController, searchController;

  const _AddMealBody({
    required this.nameController,
    required this.quantityController,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SearchBarSection(), 
          heightSpace(25),
          const _MealImageCard(),
          heightSpace(25),
          _InputFieldsSection(
            nameController: nameController,
            quantityController: quantityController,
          ),
          heightSpace(30),
          const _NutritionInfoSection(),
          heightSpace(100), 
        ],
      ),
    );
  }
}

class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite, 
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4), 
          )
        ],
      ),
      child: TextField(
        onChanged: (val) {
          if (val.length > 2) {
            context.read<AddMealCubit>().searchMeals(val);
          }
        },
        style: AppTextStyle.font11BlackW600, 
        decoration: InputDecoration(
          hintText: 'Search food...',
          hintStyle: AppTextStyle.font13GreyW400, 
          prefixIcon: Icon(Icons.search, color: ColorsManager.gray500, size: 20.sp),
          
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          
          filled: false, 
          contentPadding: EdgeInsets.symmetric(vertical: 12.h), 
        ),
      ),
    );
  }
}

class _MealImageCard extends StatelessWidget {
  const _MealImageCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.network(
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
            height: 180.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 15.h,
          left: 15.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Auto-detected', style: AppTextStyle.font16WhiteW600),
              Text('Avocado Grain Bowl', style: AppTextStyle.font16WhiteWBold),
            ],
          ),
        ),
      ],
    );
  }
}

class _InputFieldsSection extends StatelessWidget {
  final TextEditingController nameController, quantityController;
  const _InputFieldsSection({required this.nameController, required this.quantityController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomTextField(label: 'Food Name', controller: nameController),
        heightSpace(15),
        Row(
          children: [
            Expanded(child: _CustomTextField(label: 'Quantity', controller: quantityController)),
            widthSpace(15),
            const Expanded(child: _UnitDropdown()),
          ],
        ),
      ],
    );
  }
}

class _NutritionInfoSection extends StatelessWidget {
  const _NutritionInfoSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMealCubit, AddMealState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: ColorsManager.backgroundWhite,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20)],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ESTIMATED NUTRITION', style: AppTextStyle.font11BlackW600.copyWith(color: ColorsManager.gray500)),
                  const _InfoIcon(),
                ],
              ),
              heightSpace(15),
              const _NutrientRow(label: 'Total Calories', value: '420', isMain: true),
              const Divider(height: 30),
              const _NutrientProgress(label: 'Carbs', value: '45g', progress: 0.7, color: Colors.teal),
              const _NutrientProgress(label: 'Protein', value: '15g', progress: 0.4, color: Colors.brown),
              const _NutrientProgress(label: 'Fat', value: '22g', progress: 0.5, color: Colors.orange),
            ],
          ),
        );
      },
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ConfirmButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMealCubit, AddMealState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(color: ColorsManager.backgroundWhite),
          child: ElevatedButton(
            onPressed: state.status == AddMealStatus.loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              minimumSize: Size(double.infinity, 55.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
            ),
            child: state.status == AddMealStatus.loading
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

class _CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _CustomTextField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.font13GreyW400),
        heightSpace(8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorsManager.background,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
          ),
        ),
      ],
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
          child: DropdownButton<String>(
            value: 'Serving',
            isExpanded: true,
            underline: const SizedBox(),
            items: const [DropdownMenuItem(value: 'Serving', child: Text('Serving'))],
            onChanged: (v) {},
          ),
        ),
      ],
    );
  }
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon();
  @override
  Widget build(BuildContext context) => Icon(Icons.info_outline, size: 18.sp, color: ColorsManager.gray500);
}

class _NutrientRow extends StatelessWidget {
  final String label, value;
  final bool isMain;
  const _NutrientRow({required this.label, required this.value, this.isMain = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: isMain ? AppTextStyle.font18BlackBold.copyWith(fontSize: 32.sp) : AppTextStyle.font11BlackW600),
            Text(label, style: AppTextStyle.font13GreyW400),
          ],
        ),
        if (isMain) Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(color: ColorsManager.primary.withAlpha(40), shape: BoxShape.circle),
          child: Icon(Icons.restaurant, color: ColorsManager.primary, size: 20.sp),
        ),
      ],
    );
  }
}

class _NutrientProgress extends StatelessWidget {
  final String label, value;
  final double progress;
  final Color color;
  const _NutrientProgress({required this.label, required this.value, required this.progress, required this.color});

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
            backgroundColor: ColorsManager.background,
            minHeight: 6.h,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ],
      ),
    );
  }
}