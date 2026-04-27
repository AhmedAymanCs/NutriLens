part of 'cubit.dart';

enum LoginStatus { initial, loading, success, failure, passwordObscure }

class LoginState extends Equatable {
  final LoginStatus status;
  final bool rememberMe;
  final bool passwordObscure;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.rememberMe = false,
    this.passwordObscure = false, this.errorMessage = "",
  });
  LoginState copyWith({
    LoginStatus? status,
    bool? rememberMe,
    bool? passwordObscure,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      rememberMe: rememberMe ?? this.rememberMe,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, rememberMe, passwordObscure, errorMessage];
}
