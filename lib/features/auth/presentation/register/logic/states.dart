part of 'cubit.dart';

enum RegisterStatus { initial, passwordObscure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final bool passwordObscure, confirmPasswordObscure;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.passwordObscure = false,
    this.confirmPasswordObscure = false,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    bool? passwordObscure,
    bool? confirmPasswordObscure,
  }) {
    return RegisterState(
      status: status ?? this.status,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      confirmPasswordObscure:
          confirmPasswordObscure ?? this.confirmPasswordObscure,
    );
  }

  @override
  List<Object?> get props => [status, passwordObscure, confirmPasswordObscure];
}
