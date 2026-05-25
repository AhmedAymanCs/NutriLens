// class NutritionModel {
//   final num calories;
//   final num protein;
//   final num carbs;
//   final num fats;

//   const NutritionModel({
//     this.calories = 0,
//     this.protein = 0,
//     this.carbs = 0,
//     this.fats = 0,
//   });

//   factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
//     calories: json['calories'] ?? 0,
//     protein: json['protein'] ?? 0,
//     carbs: json['carbs'] ?? 0,
//     fats: json['fats'] ?? 0,
//   );

//   Map<String, dynamic> toJson() => {
//     'calories': calories,
//     'protein': protein,
//     'carbs': carbs,
//     'fats': fats,
//   };
// }

// class IngredientModel {
//   final String name;
//   final num grams;

//   const IngredientModel({
//     this.name = '',
//     this.grams = 0,
//   });

//   factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
//     name: json['name'] ?? '',
//     grams: json['grams'] ?? 0,
//   );

//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'grams': grams,
//   };

//   IngredientModel copyWith({
//     String? name,
//     num? grams,
//   }) => IngredientModel(
//     name: name ?? this.name,
//     grams: grams ?? this.grams,
//   );
// }

// class MealModel {
//   final String? mealId;
//   final String mealName;
//   final String imageUrl;
//   final String mealType;
//   final NutritionModel nutrition;
//   final List<IngredientModel> ingredients;

//   const MealModel({
//     this.mealId,
//     this.mealName = '',
//     this.imageUrl =
//         "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
//     this.mealType = "Unknown",
//     this.nutrition = const NutritionModel(),
//     this.ingredients = const [],
//   });

//   factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
//     mealId: json['meal_id'],
//     mealName: json['meal_name'] ?? '',
//     imageUrl: json['image_url'] ??
//         "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
//     mealType: json['meal_type'] ?? 'Unknown',
//     nutrition: json['nutrition'] != null
//         ? NutritionModel.fromJson(json['nutrition'])
//         : const NutritionModel(),
//     ingredients: json['ingredients'] != null
//         ? List<IngredientModel>.from(
//             json['ingredients'].map((x) => IngredientModel.fromJson(x)),
//           )
//         : const [],
//   );

//   Map<String, dynamic> toJson() => {
//     "meal_id": mealId,
//     "meal_name": mealName,
//     "image_url": imageUrl,
//     "meal_type": mealType,
//     "nutrition": nutrition.toJson(),
//     "ingredients": ingredients.map((x) => x.toJson()).toList(),
//   };

//   MealModel copyWith({
//     String? mealId,
//     String? mealName,
//     String? imageUrl,
//     String? mealType,
//     NutritionModel? nutrition,
//     List<IngredientModel>? ingredients,
//   }) => MealModel(
//     mealId: mealId ?? this.mealId,
//     mealName: mealName ?? this.mealName,
//     imageUrl: imageUrl ?? this.imageUrl,
//     mealType: mealType ?? this.mealType,
//     nutrition: nutrition ?? this.nutrition,
//     ingredients: ingredients ?? this.ingredients,
//   );
// }
