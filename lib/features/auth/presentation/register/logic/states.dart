part of 'cubit.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final bool passwordObscure;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.passwordObscure = false,
  });

  RegisterState copyWith({RegisterStatus? status, bool? passwordObscure}) {
    return RegisterState(
      status: status ?? this.status,
      passwordObscure: passwordObscure ?? this.passwordObscure,
    );
  }

  @override
  List<Object?> get props => [status, passwordObscure];
}
