part of 'cubit.dart';

enum Gender { male, female }

enum Goal { loseWeight, maintainWeight, gainWeight }
enum OnboardingStatus { initial, loading, success, failure, userSession }


class OnboardingState extends Equatable {
  final OnboardingStatus status;
  final Gender? selectedGender;
  final String? selectedGenderValue;
  final Goal? selectedGoal;
  final String? selectedGoalValue;
  final int? selectedAgeValue;
  final String? selectedHeightValue;
  final String? selectedWeightValue;
  final UserDataModel? userModel;
  final String? errorMessage;

  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.selectedGender,
    this.selectedGenderValue = "",
    this.selectedGoal,
    this.selectedGoalValue = "",
    this.selectedAgeValue,
    this.selectedHeightValue = "",
    this.selectedWeightValue = "",
    this.userModel,
    this.errorMessage = "",
  });

  OnboardingState copyWith({
    OnboardingStatus? status,
    Gender? selectedGender,
    String? selectedGenderValue,
    Goal? selectedGoal,
    String? selectedGoalValue,
    int? selectedAgeValue,
    String? selectedHeightValue,
    String? selectedWeightValue,
    UserDataModel? userModel,
    String? errorMessage
  }) {
    return OnboardingState(
      status: status ?? this.status,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedGenderValue: selectedGenderValue ?? this.selectedGenderValue,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedGoalValue: selectedGoalValue ?? this.selectedGoalValue,
      selectedAgeValue: selectedAgeValue ?? this.selectedAgeValue,
      selectedHeightValue: selectedHeightValue ?? this.selectedHeightValue,
      selectedWeightValue: selectedWeightValue ?? this.selectedWeightValue,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedGender,
    selectedGenderValue,
    selectedGoal,
    selectedGoalValue,
    selectedAgeValue,
    selectedHeightValue,
    selectedWeightValue,
    userModel,
    errorMessage
  ];
}
