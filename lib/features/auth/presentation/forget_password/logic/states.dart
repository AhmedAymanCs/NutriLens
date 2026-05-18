part of 'cubit.dart';

enum ForgetPasswordStatus { initial, loading, success, failure }

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;
  final String? errorMessage;

  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.errorMessage = "",
  });

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? errorMessage,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
