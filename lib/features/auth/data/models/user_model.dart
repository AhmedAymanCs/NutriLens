// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

class UserDataModel {
  final String uid, email;
  final String? name, photoURL;
  final String gender;
  final String goal;
  final int age;
  final String height;
  final String weight;

  UserDataModel({
    required this.uid,
    required this.email,
    this.name,
    this.photoURL,
    required this.gender,
    required this.goal,
    required this.age,
    required this.height,
    required this.weight,
  });

  factory UserDataModel.fromFirebaseUser(User user) => UserDataModel(
    uid: user.uid,
    email: user.email ?? "example@email.com",
    name: user.displayName ?? "",
    photoURL: user.photoURL ?? "",
    gender: '',
    goal: '',
    age: 0,
    height: '',
    weight: '',
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'name': name,
    'photoURL': photoURL,
    'gender': gender,
    'goal': goal,
    'age': age,
    'height': height,
    'weight': weight,
  };
}





// class UserModelRequest {
//   final String? name;
//   final String email;
//   final String password;

//   UserModelRequest({
//     this.name,
//     required this.email,
//     required this.password,
//   });
// }
