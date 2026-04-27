part of 'cubit.dart';

enum RegisterStatus { initial, loading, success, failure, passwordObscure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final bool passwordObscure, confirmPasswordObscure;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.passwordObscure = false,
    this.confirmPasswordObscure = false,
    this.errorMessage = '',
  });

  RegisterState copyWith({
    RegisterStatus? status,
    bool? passwordObscure,
    bool? confirmPasswordObscure,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      confirmPasswordObscure:
          confirmPasswordObscure ?? this.confirmPasswordObscure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    passwordObscure,
    confirmPasswordObscure,
    errorMessage,
  ];
}
