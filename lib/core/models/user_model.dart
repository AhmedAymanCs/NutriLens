import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid, email;
  final String name, photoURL;
  final String gender;
  final String goal;
  final int age;
  final double height;
  final double weight;

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
  });

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
    };
  }

  factory UserModel.fromFirebaseAuth(User user, String name) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? name,
      photoURL:
          user.photoURL ??
          "https://cutiedp.com/wp-content/uploads/2025/08/no-dp-image-5.webp",
    );
  }

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'] ?? "Unknown Name",
      email: json['email'],
      photoURL:
          json['photo_url'] ??
          "https://cutiedp.com/wp-content/uploads/2025/08/no-dp-image-5.webp",
      gender: json['gender'] ?? "",
      goal: json['goal'] ?? "",
      age: json['age'] ?? 0,
      height: json['height'] ?? 0.0,
      weight: json['weight'] ?? 0.0,
    );
  }

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
    );
  }
}
