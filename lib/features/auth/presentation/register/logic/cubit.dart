import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterCubit(this._authRepository) : super(RegisterState());

  void changePasswordVisible() {
    emit(state.copyWith(status: RegisterStatus.initial, passwordObscure: !state.passwordObscure));
  }
  void changeConfirmPasswordVisible() {
    emit(state.copyWith(confirmPasswordObscure: !state.confirmPasswordObscure));
  }

  Future<void> signUp({required String email, required String password, required String name}) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    final response = await _authRepository.signUp(
      email: email,
      password: password,
      name: name,
    );
    response.fold(
      (error) => emit(
        state.copyWith(status: RegisterStatus.failure, errorMessage: error),
      ),
      (success) =>
          emit(state.copyWith(status: RegisterStatus.success)),
    );
  }
}
