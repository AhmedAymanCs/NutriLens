import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/add_meal/logic/cubit.dart';
import 'package:nutrilens/features/add_meal/logic/state.dart';

part 'shared_widgets.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<AddMealCubit>(),
      child: const _AddMealView(),
    );
  }
}

class _AddMealView extends StatefulWidget {
  const _AddMealView();

  @override
  State<_AddMealView> createState() => _AddMealViewState();
}

class _AddMealViewState extends State<_AddMealView> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    nameController     = TextEditingController();
    quantityController = TextEditingController(text: '1');
    searchController   = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMealCubit, AddMealState>(
      listenWhen: (prev, curr) =>prev.status != curr.status || prev.selectedMeal != curr.selectedMeal,
      listener: (context, state) {
        if (state.selectedMeal != null && nameController.text.isEmpty) {
        nameController.text = state.selectedMeal!.name;
      }
        if (state.status == AddMealStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Meal added successfully!'),
              backgroundColor: ColorsManager.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop();
        } else if (state.status == AddMealStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        appBar: AppBar(title: const Text("Add Meal")),
        body: _AddMealBody(
          nameController:     nameController,
          quantityController: quantityController,
          searchController:   searchController,
        ),
      ),
    );
  }
}

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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SearchBarSection(
                  searchController: searchController,
                  nameController:   nameController,
                ),
                const _MealImageCard(),
                heightSpace(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _InputFieldsSection(
                    nameController:     nameController,
                    quantityController: quantityController,
                  ),
                ),
                heightSpace(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const _NutritionInfoSection(),
                ),
                heightSpace(20),
              ],
            ),
          ),
        ),
        _ConfirmButton(
          onPressed: () => context.read<AddMealCubit>().addNewMeal(),
        ),
      ],
    );
  }
}
