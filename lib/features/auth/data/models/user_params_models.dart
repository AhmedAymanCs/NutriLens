class RegisterParamsModels {
  final String name;
  final String email;
  final String password;

  RegisterParamsModels({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'email': email};
  }
}

class UserOnboardingParamsModel {
  final String gender;
  final String goal;
  final int age;
  final double height;
  final double weight;

  UserOnboardingParamsModel({
    required this.gender,
    required this.goal,
    required this.age,
    required this.height,
    required this.weight,
  });
  
}
