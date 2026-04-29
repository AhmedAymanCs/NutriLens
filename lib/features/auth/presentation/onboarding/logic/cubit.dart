import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/models/user_model.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final AuthRepository _authRepository;
  OnboardingCubit(this._authRepository) : super(const OnboardingState());

  void selectGender({required Gender gender, required String value}) {
    emit(state.copyWith(selectedGender: gender, selectedGenderValue: value));
  }

  void selectGoal({required Goal goal, required String value}) {
    emit(state.copyWith(selectedGoal: goal, selectedGoalValue: value));
  }

  void selectAge({required int age}) {
    emit(state.copyWith(selectedAgeValue: age));
  }

  void selectHeight({required String selectedHeightValue}) {
    emit(state.copyWith(selectedHeightValue: selectedHeightValue));
  }

  void selectWeight({required String selectedWeightValue}) {
    emit(state.copyWith(selectedWeightValue: selectedWeightValue));
  }

  Future<void> saveDataToFirestore({required String name}) async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final response = await _authRepository.addDataToFirestore(
      state: state,
      name: name,
    );
    response.fold(
      (error) => emit(state.copyWith(status: OnboardingStatus.failure)),
      (success) => emit(state.copyWith(status: OnboardingStatus.success)),
    );
    await getUserSession();
  }

  Future<void> getUserSession () async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final response = await _authRepository.getUserSession();
    response.fold(
      (error) => emit(
        state.copyWith(status: OnboardingStatus.failure, errorMessage: error),
      ),
      (userModel) => emit(
        state.copyWith(status: OnboardingStatus.userSession, userModel: userModel),
      ),
    );
  }
}
