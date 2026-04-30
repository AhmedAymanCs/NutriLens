part of 'add_screen.dart';

class _AddMealBody extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController searchController;

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
          _buildSearchBar(context),
          SizedBox(height: 25.h),
          _buildImageCard(),
          SizedBox(height: 25.h),
          _buildInputFields(),
          SizedBox(height: 30.h),
          _buildNutritionInfo(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [BoxShadow(color: ColorsManager.overlayBlack10, blurRadius: 10)],
      ),
      child: TextField(
        controller: searchController,
        onChanged: (val) {
          if (val.length > 2) context.read<AddMealCubit>().searchMeals(val);
        },
        decoration: InputDecoration(
          hintText: 'Search for food...',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: ColorsManager.gray500),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.network(
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
        height: 180.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        _CustomTextField(label: 'Food Name', controller: nameController),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(child: _CustomTextField(label: 'Quantity', controller: quantityController)),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unit', style: AppTextStyle.font11BlackW600),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                        color: ColorsManager.backgroundWhite,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: DropdownButton<String>(
                      value: 'Serving',
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: const [DropdownMenuItem(value: 'Serving', child: Text('Serving'))],
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNutritionInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calories', style: AppTextStyle.font14WhiteW400.copyWith(color: Colors.black)),
              Text('420 kcal', style: AppTextStyle.font18BlackBold),
            ],
          ),
          const Divider(),
          _NutrientProgress(label: 'Carbs', value: '45g', progress: 0.7, color: Colors.orange),
          _NutrientProgress(label: 'Protein', value: '12g', progress: 0.3, color: Colors.green),
          _NutrientProgress(label: 'Fat', value: '18g', progress: 0.5, color: Colors.red),
        ],
      ),
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
          child: ElevatedButton(
            onPressed: state.status == AddMealStatus.loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              minimumSize: Size(double.infinity, 55.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
            ),
            child: state.status == AddMealStatus.loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text('Confirm Meal', style: AppTextStyle.font16WhiteWBold),
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
        Text(label, style: AppTextStyle.font11BlackW600),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorsManager.backgroundWhite,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
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
  const _NutrientProgress({required this.label, required this.value, required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(label), Text(value)],
          ),
          SizedBox(height: 5.h),
          LinearProgressIndicator(value: progress, color: color, backgroundColor: Colors.grey[200]),
        ],
      ),
    );
  }
}