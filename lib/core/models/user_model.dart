import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart'; // تأكد من المسار

class UserModel {
  final String uid, email;
  final String name, photoURL;
  final String gender;
  final String goal;
  final int age;
  final double height;
  final double weight;

  final int dailyCalorieGoal;
  final int carbsGoal;
  final int proteinGoal;
  final int fatGoal;

  final int dailyCalorieConsumed;
  final int carbsConsumed;
  final int proteinConsumed;
  final int fatConsumed;

  final List<MealModel> todayMeals;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoURL,
    this.gender = "",
    this.goal = "",
    this.age = 0,
    this.height = 0.0,
    this.weight = 0.0,
    this.dailyCalorieGoal = 0,
    this.carbsGoal = 0,
    this.proteinGoal = 0,
    this.fatGoal = 0,
    this.dailyCalorieConsumed = 0,
    this.carbsConsumed = 0,
    this.proteinConsumed = 0,
    this.fatConsumed = 0,
    this.todayMeals = const [],
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoURL,
    String? gender,
    String? goal,
    int? age,
    double? height,
    double? weight,
    int? dailyCalorieGoal,
    int? carbsGoal,
    int? proteinGoal,
    int? fatGoal,
    int? dailyCalorieConsumed,
    int? carbsConsumed,
    int? proteinConsumed,
    int? fatConsumed,
    List<MealModel>? todayMeals,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      carbsGoal: carbsGoal ?? this.carbsGoal,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      fatGoal: fatGoal ?? this.fatGoal,
      dailyCalorieConsumed: dailyCalorieConsumed ?? this.dailyCalorieConsumed,
      carbsConsumed: carbsConsumed ?? this.carbsConsumed,
      proteinConsumed: proteinConsumed ?? this.proteinConsumed,
      fatConsumed: fatConsumed ?? this.fatConsumed,
      todayMeals: todayMeals ?? this.todayMeals,
    );
  }

  factory UserModel.fromFirebaseAuth(User user, String name) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? name,
      photoURL: user.photoURL ?? "https://cutiedp.com/wp-content/uploads/2025/08/no-dp-image-5.webp",
    );
  }

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? "Unknown Name",
      email: json['email'] ?? '',
      photoURL: json['photo_url'] ?? "https://cutiedp.com/wp-content/uploads/2025/08/no-dp-image-5.webp",
      gender: json['gender'] ?? "",
      goal: json['goal'] ?? "",
      age: json['age'] ?? 0,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      dailyCalorieGoal: json['daily_calorie_goal'] ?? 0,
      carbsGoal: json['carbs'] ?? 0,
      proteinGoal: json['protein'] ?? 0,
      fatGoal: json['fat'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photo_url': photoURL,
      'gender': gender,
      'goal': goal,
      'age': age,
      'height': height,
      'weight': weight,
      'daily_calorie_goal': dailyCalorieGoal,
      'carbs': carbsGoal,
      'protein': proteinGoal,
      'fat': fatGoal,
    };
  }
}