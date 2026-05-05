import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';

extension GenderValue on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
    }
  }
}

extension GoalValues on Goal {
  String get label {
    switch (this) {
      case Goal.loseWeight:
        return "Lose Weight";
      case Goal.gainWeight:
        return "Gain Weight";
      case Goal.maintainWeight:
        return "Maintain Weight";
    }
  }
}

