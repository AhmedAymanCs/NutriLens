import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';
part 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterCubit(this._authRepository) : super(RegisterState());

  void changePasswordVisible() {
    emit(state.copyWith(passwordObscure: !state.passwordObscure));
  }
}
