import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(LoginState());

  void changePasswordVisible() {
    emit(state.copyWith(passwordObscure: !state.passwordObscure));
  }

  void changeRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }
}
