part of 'cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final UserModel? userModel;
  final List<MealModel>? mealModels;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.userModel,
    this.mealModels,
    this.errorMessage = '',
  });
  HomeState copyWith({
    HomeStatus? status,
    UserModel? userModel,
    List<MealModel>? mealModels,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      mealModels: mealModels ?? this.mealModels,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, userModel, mealModels, errorMessage];
}
