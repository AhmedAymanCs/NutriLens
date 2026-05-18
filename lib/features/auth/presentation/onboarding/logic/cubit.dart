import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final AuthRepository _authRepository;
  OnboardingCubit(this._authRepository) : super(const OnboardingState());

  bool isStepValid({required int currentPage}) {
    switch (currentPage) {
      case 0:
        return state.selectedGender != null;

      case 1:
        return state.selectedGoal != null;

      case 2:
        return state.selectedAgeValue != 0;

      case 3:
        return state.selectedHeight != 0.0 && state.selectedWeight != 0.0;

      default:
        return false;
    }
  }

  void selectGender({required Gender gender}) {
    emit(state.copyWith(selectedGender: gender));
  }

  void selectGoal({required Goal goal}) {
    emit(state.copyWith(selectedGoal: goal));
  }

  void selectAge({required int selectedAge}) {
    emit(state.copyWith(selectedAgeValue: selectedAge));
  }

  void selectHeight({required double selectedHeight}) {
    emit(state.copyWith(selectedHeight: selectedHeight));
  }

  void selectWeight({required double selectedWeight}) {
    emit(state.copyWith(selectedWeight: selectedWeight));
  }

  Future<void> signUp({
    required RegisterParamsModels params,
    required UserOnboardingParamsModel userDataParams,
  }) async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final response = await _authRepository.signUp(
      params: params,
      userDataParams: userDataParams,
    );
    response.fold(
      (error) => emit(
        state.copyWith(status: OnboardingStatus.failure, errorMessage: error),
      ),
      (userModel) => emit(
        state.copyWith(status: OnboardingStatus.success, userModel: userModel),
      ),
    );
  }
}
