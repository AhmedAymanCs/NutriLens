import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(const LoginState());

  void changePasswordVisible() {
    emit(
      state.copyWith(
        status: LoginStatus.passwordObscure,
        passwordObscure: !state.passwordObscure,
      ),
    );
  }

  Future<void> signIn({required String email, required String password, bool rememberMe = false}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final response = await _authRepository.signIn(
      email: email,
      password: password,
    );
    response.fold(
      (error) => emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: error),
      ),
      (userModel) => emit(state.copyWith(status: LoginStatus.success, userModel: userModel)),
    );
  }

  void changeRememberMe() async {
    emit(
      state.copyWith(
        status: LoginStatus.rememberMe,
        rememberMe: !state.rememberMe,
      ),
    );
  }


}
