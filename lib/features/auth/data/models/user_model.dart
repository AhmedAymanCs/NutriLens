class UserDataModel {
  final String uid, email;
  final String? name, photoURL;
  final String? gender;
  final String? goal;
  final int? age;
  final String? height;
  final String? weight;

  UserDataModel({
    required this.uid,
    required this.email,
    this.name,
    this.photoURL,
    this.gender,
    this.goal,
    this.age,
    this.height,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name ?? "",
      'email': email,
      'photo_url': photoURL ?? "",
      'gender': gender ?? "",
      'goal': goal ?? "",
      'age': age ?? 0,
      'height': height ?? "",
      'weight': weight ?? "",
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photoURL: json['photo_url'],
      gender: json['gender'],
      goal: json['goal'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
