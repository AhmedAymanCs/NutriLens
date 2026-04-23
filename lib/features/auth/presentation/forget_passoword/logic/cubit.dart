import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/data/repository/auth_repository.dart';

part 'states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository _authRepository;
  ForgetPasswordCubit(this._authRepository) : super(ForgetPasswordState());
}
