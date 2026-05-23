import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';

class IngredientAutoCompleteField extends StatelessWidget {
  final List<FoodItemModel> foodItems;
  final TextEditingController controller;
  final void Function(FoodItemModel selected) onSelected;

  const IngredientAutoCompleteField({
    super.key,
    required this.foodItems,
    required this.controller,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<FoodItemModel>(
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.trim().isEmpty) return [];
        final q = textEditingValue.text.trim().toLowerCase();
        return foodItems.where(
          (item) =>
              item.name.toLowerCase().contains(q) ||
              item.nameEn.toLowerCase().contains(q),
        );
      },
      displayStringForOption: (item) => item.name,
      onSelected: (item) {
        controller.text = item.name;
        onSelected(item);
      },
      fieldViewBuilder: (context, textController, focusNode, onSubmitted) {
        // Sync external controller → internal controller
        textController.text = controller.text;
        return TextFormField(
          controller: textController,
          focusNode: focusNode,
          cursorColor: ColorsManager.primary,
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Required';
            final exists = foodItems.any(
              (item) =>
                  item.name.toLowerCase() == value.trim().toLowerCase() ||
                  item.nameEn.toLowerCase() == value.trim().toLowerCase(),
            );
            if (!exists) return 'Not found in food items';
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Ingredient',
            hintStyle: const TextStyle(color: ColorsManager.gray500),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.error),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.gray500),
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12.r),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200.h),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 4.h),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final item = options.elementAt(index);
                  return ListTile(
                    title: Text(item.name, style: AppTextStyle.font15GreyW500),
                    subtitle: Text(
                      item.nameEn,
                      style: TextStyle(
                        color: ColorsManager.gray500,
                        fontSize: 12.sp,
                      ),
                    ),
                    onTap: () => onSelected(item),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
