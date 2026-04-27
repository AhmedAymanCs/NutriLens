import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(LoginState());

  void changePasswordVisible() {
    emit(state.copyWith(status: LoginStatus.passwordObscure, passwordObscure: !state.passwordObscure));
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final response = await _authRepository.signIn(email: email, password: password);
    response.fold(
      (error) => emit(state.copyWith(status: LoginStatus.failure)),
      (success) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }

  void changeRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }
}
