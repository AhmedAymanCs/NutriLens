part of 'cubit.dart';

enum ForgetPasswordStatus { initial, loading, success, failure }

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;

  const ForgetPasswordState({this.status = ForgetPasswordStatus.initial});

  ForgetPasswordState copyWith({ForgetPasswordStatus? status}) {
    return ForgetPasswordState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
