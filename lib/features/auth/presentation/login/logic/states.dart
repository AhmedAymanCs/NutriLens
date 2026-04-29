part of 'cubit.dart';

enum LoginStatus { initial, loading, success, failure, passwordObscure, rememberMe }

class LoginState extends Equatable {
  final LoginStatus status;
  final bool rememberMe;
  final bool passwordObscure;
  final String errorMessage;
  final UserDataModel? userModel;

  const LoginState({
    this.status = LoginStatus.initial,
    this.rememberMe = false,
    this.passwordObscure = false,
    this.errorMessage = "",
    this.userModel,
  });
  LoginState copyWith({
    LoginStatus? status,
    bool? rememberMe,
    bool? passwordObscure,
    String? errorMessage,
    UserDataModel? userModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      rememberMe: rememberMe ?? this.rememberMe,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [
    status,
    rememberMe,
    passwordObscure,
    errorMessage,
    userModel,
  ];
}
