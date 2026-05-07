import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';
import 'package:nutrilens/features/add_meal/logic/cubit.dart';
import 'package:nutrilens/features/add_meal/logic/state.dart'; 

part 'shared_widgets.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: 'Avocado Grain Bowl');
    final TextEditingController quantityController = TextEditingController(text: '1');
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorsManager.background, 
      appBar: AppBar(
        backgroundColor: ColorsManager.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorsManager.primary, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Meal', style: AppTextStyle.font18BlackBold),
        centerTitle: true,
      ),
      body: BlocListener<AddMealCubit, AddMealState>(
        listenWhen: (previous, current) =>
            current.status == AddMealStatus.success || current.status == AddMealStatus.error,
        listener: (context, state) {
          if (state.status == AddMealStatus.success && state.errorMessage == null) {
             customSnackBar(
                context: context, 
                message: 'Meal Added Successfully!', 
                isErrorMessage: false
             );
             Navigator.pop(context);
          } else if (state.status == AddMealStatus.error) {
            customSnackBar(
              context: context, 
              message: state.errorMessage ?? 'Error occurred', 
              isErrorMessage: true
            );
          }
        },
        child: _AddMealBody(
          nameController: nameController,
          quantityController: quantityController,
          searchController: searchController,
        ),
      ),
      bottomSheet: _ConfirmButton(
        onPressed: () {
          final meal = MealModel(
            id: DateTime.now().toString(),
            name: nameController.text,
            imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
            calories: 420.0,
            ingredients: const [],
          );
          context.read<AddMealCubit>().addNewMeal(meal);
        },
      ),
    );
  }
}