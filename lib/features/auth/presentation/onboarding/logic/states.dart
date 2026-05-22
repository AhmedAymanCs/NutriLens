part of 'cubit.dart';

enum Gender { male, female }

enum Goal { loseWeight, maintainWeight, gainWeight }

enum OnboardingStatus { initial, loading, success, failure, userSession }

class OnboardingState extends Equatable {
  final OnboardingStatus status;
  final Gender? selectedGender;
  final Goal? selectedGoal;
  final int? selectedAgeValue;
  final double? selectedHeight;
  final double? selectedWeight;
  final UserModel? userModel;
  final String? errorMessage;

  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.selectedGender,
    this.selectedGoal,
    this.selectedAgeValue = 0,
    this.selectedHeight = 0.0,
    this.selectedWeight = 0.0,
    this.userModel,
    this.errorMessage = "",
  });

  OnboardingState copyWith({
    OnboardingStatus? status,
    Gender? selectedGender,
    Goal? selectedGoal,
    int? selectedAgeValue,
    double? selectedHeight,
    double? selectedWeight,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedAgeValue: selectedAgeValue ?? this.selectedAgeValue,
      selectedHeight: selectedHeight ?? this.selectedHeight,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedGender,
    selectedGoal,
    selectedAgeValue,
    selectedHeight,
    selectedWeight,
    userModel,
    errorMessage,
  ];
}
