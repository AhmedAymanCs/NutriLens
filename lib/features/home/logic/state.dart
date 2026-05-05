part of 'cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeDataModel? homeDataModel;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.homeDataModel,
    this.errorMessage = '',
  });
  HomeState copyWith({
    HomeStatus? status,
    HomeDataModel? homeDataModel,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      homeDataModel: homeDataModel ?? this.homeDataModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, homeDataModel, errorMessage];
}
