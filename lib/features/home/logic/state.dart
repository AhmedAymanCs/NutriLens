part of 'cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final UserModel? userModel;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.userModel,
    this.errorMessage = '',
  });
  HomeState copyWith({
    HomeStatus? status,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, userModel, errorMessage];
}
