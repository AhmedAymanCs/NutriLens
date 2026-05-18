import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';

part 'states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository _authRepository;
  ForgetPasswordCubit(this._authRepository)
    : super(const ForgetPasswordState());

  Future<void> resetPassword({required String email}) async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));
    final response = await _authRepository.resetPassword(email: email);
    response.fold(
      (error) => emit(state.copyWith(status: ForgetPasswordStatus.failure)),
      (success) => emit(state.copyWith(status: ForgetPasswordStatus.success)),
    );
  }
}
