import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void changePasswordVisible() {
    emit(
      state.copyWith(
        status: RegisterStatus.passwordObscure,
        passwordObscure: !state.passwordObscure,
      ),
    );
  }

  void changeConfirmPasswordVisible() {
    emit(
      state.copyWith(
        status: RegisterStatus.passwordObscure,
        confirmPasswordObscure: !state.confirmPasswordObscure,
      ),
    );
  }
}
