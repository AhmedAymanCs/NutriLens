part of 'cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final bool rememberMe;
  final bool passwordObscure;

  const LoginState({
    this.status = LoginStatus.initial,
    this.rememberMe = false,
    this.passwordObscure = false,
  });
  LoginState copyWith({
    LoginStatus? status,
    bool? rememberMe,
    bool? passwordObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      rememberMe: rememberMe ?? this.rememberMe,
      passwordObscure: passwordObscure ?? this.passwordObscure,
    );
  }

  @override
  List<Object?> get props => [status, rememberMe, passwordObscure];
}
