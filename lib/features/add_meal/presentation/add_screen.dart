import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';
import 'package:nutrilens/features/add_meal/logic/cubit.dart';

part 'shared_widgets.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController nameController = TextEditingController(text: 'Avocado Grain Bowl');
  final TextEditingController quantityController = TextEditingController(text: '1');
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // هنا الجزء بتاع الاسناك بار اجيبه كاستم 
      // هندل هنا الالوان الاتنين ابيض كدا غلط لازم اظبط عشان اعمل الثيم وانا بغير الاسود 
      backgroundColor: ColorsManager.background,
      appBar: AppBar(
        backgroundColor: ColorsManager.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: ColorsManager.primary, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        // هنا هرد استرنج 
        title: Text('Add Meal', style: AppTextStyle.font18BlackBold),
        centerTitle: true,
      ),
      body: BlocListener<AddMealCubit, AddMealState>(
        listenWhen: (previous, current) =>
            current.status == AddMealStatus.success || current.status == AddMealStatus.error,
        listener: (context, state) {
          if (state.status == AddMealStatus.success) {
            if (state.meals.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Meal Added Successfully!'), backgroundColor: Colors.green),
              );
              Navigator.pop(context);
            }
          } else if (state.status == AddMealStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error'), backgroundColor: Colors.red),
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