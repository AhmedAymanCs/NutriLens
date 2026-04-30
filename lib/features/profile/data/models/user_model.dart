class UserModel {
  final String uid;
  final String name;
  final String email;
  final int age;
  final String gender;
  final double weight;
  final double height;
  final int dailyCalorieGoal;
  final String? photoUrl; 
  final int streakCount;
  final bool isPro;

  UserModel({
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

 factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json['uid'] as String? ?? '',
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    age: int.tryParse(json['age'].toString()) ?? 0,
    weight: double.tryParse(json['weight'].toString()) ?? 0.0,
    height: double.tryParse(json['height'].toString()) ?? 0.0,
    dailyCalorieGoal: int.tryParse(json['dailyCalorieGoal'].toString()) ?? 0,
    streakCount: json['streakCount'] as int? ?? 0,
    isPro: json['isPro'] as bool? ?? false,
    photoUrl: json['photoUrl'] as String?, gender: '',
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
}