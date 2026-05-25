class NutritionModel {
  final num totalCalories;
  final num totalProteinG;
  final num totalCarbsG;
  final num totalFatG;

  NutritionModel({
    required this.totalCalories,
    required this.totalProteinG,
    required this.totalCarbsG,
    required this.totalFatG,
  });
  factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
    totalCalories: json['total_calories'] ?? 0,
    totalProteinG: json['total_protein_g'] ?? 0,
    totalCarbsG: json['total_carbs_g'] ?? 0,
    totalFatG: json['total_fat_g'] ?? 0,
  );
  NutritionModel copyWith({
    num? totalCalories,
    num? totalProteinG,
    num? totalCarbsG,
    num? totalFatG,
  }) => NutritionModel(
    totalCalories: totalCalories ?? this.totalCalories,
    totalProteinG: totalProteinG ?? this.totalProteinG,
    totalCarbsG: totalCarbsG ?? this.totalCarbsG,
    totalFatG: totalFatG ?? this.totalFatG,
  );

  Map<String, dynamic> toJson() => {
    'total_calories': totalCalories,
    'total_protein_g': totalProteinG,
    'total_carbs_g': totalCarbsG,
    'total_fat_g': totalFatG,
  };
}
