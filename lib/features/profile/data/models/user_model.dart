import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String weight;
  final String height;
  final int dailyCalorieGoal;
  final String? photoUrl;
  final int streakCount;
  final bool isPro;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.dailyCalorieGoal,
    this.photoUrl,
    this.streakCount = 0,
    this.isPro = false,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? age,
    String? gender,
    String? weight,
    String? height,
    int? dailyCalorieGoal,
    String? photoUrl,
    int? streakCount,
    bool? isPro,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      photoUrl: photoUrl ?? this.photoUrl,
      streakCount: streakCount ?? this.streakCount,
      isPro: isPro ?? this.isPro,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      weight: json['weight'] ?? '',
      height: json['height'] ?? '',
      dailyCalorieGoal: json['dailyCalorieGoal'] ?? 0,
      streakCount: json['streakCount'] ?? 0,
      isPro: json['isPro'] ?? false,
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'dailyCalorieGoal': dailyCalorieGoal,
      'photoUrl': photoUrl,
      'streakCount': streakCount,
      'isPro': isPro,
    };
  }

  @override
  List<Object?> get props => [
    uid,
    name,
    email,
    age,
    gender,
    weight,
    height,
    dailyCalorieGoal,
    photoUrl,
    streakCount,
    isPro,
  ];
}
