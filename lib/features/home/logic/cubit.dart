import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/home/data/repository/repositroy.dart';

part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState());

  Future<void> getLocalUserData() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _homeRepository.getLocalUserData();

    result.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: failure),
      ),
      (userModel) => emit(
        state.copyWith(status: HomeStatus.success, userModel: userModel),
      ),
    );
  }

  Future<void> getRemoteUserData() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _homeRepository.getRemoteUserData();

    result.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: failure),
      ),
      (fetchedUser) {
        UserModel userToDisplay = fetchedUser;

        if (userToDisplay.dailyCalorieGoal == 0 &&
            userToDisplay.carbsGoal == 0 &&
            userToDisplay.proteinGoal == 0 &&
            userToDisplay.fatGoal == 0 &&
            userToDisplay.weight > 0) {
          userToDisplay = calculateDailyGoals(userToDisplay);

          emit(
            state.copyWith(
              status: HomeStatus.success,
              userModel: userToDisplay,
            ),
          );

          _homeRepository.updateUserData(userToDisplay);
        } else {
          emit(
            state.copyWith(status: HomeStatus.success, userModel: fetchedUser),
          );
        }
      },
    );
    calculateDailyCaloriesOfMeals();
  }

  UserModel calculateDailyGoals(UserModel user) {
    final double bmr;

    if (user.gender.toLowerCase() == 'male') {
      bmr = (10 * user.weight) + (6.25 * user.height) - (5 * user.age) + 5;
    } else {
      bmr = (10 * user.weight) + (6.25 * user.height) - (5 * user.age) - 161;
    }

    final double tdee = bmr * 1.2;

    double targetCalories = tdee;
    final String currentGoal = user.goal.toLowerCase().trim();

    if (currentGoal.contains('gain') || currentGoal == 'Gain Weight') {
      targetCalories += 500;
    } else if (currentGoal.contains('lose') || currentGoal == 'Lose Weight') {
      targetCalories -= 500;
    }

    final double carbs = (targetCalories * 0.50) / 4;

    final double protein = (targetCalories * 0.30) / 4;

    final double fats = (targetCalories * 0.20) / 9;

    return user.copyWith(
      dailyCalorieGoal: targetCalories.round(),
      carbsGoal: carbs.round(),
      proteinGoal: protein.round(),
      fatGoal: fats.round(),
      dailyCalorieConsumed: 0,
      carbsConsumed: 0,
      proteinConsumed: 0,
      fatConsumed: 0,
    );
  }

  void calculateDailyCaloriesOfMeals() {
    final todaysMeals = state.userModel?.todayMeals ?? [];
    if (todaysMeals.isEmpty) return;

    final totalCalories = todaysMeals.fold<double>(
      0,
      (sum, meal) => sum + meal.calories,
    );
    final totalProtein = todaysMeals.fold<double>(
      0,
      (sum, meal) => sum + meal.protein,
    );
    final totalCarbs = todaysMeals.fold<double>(
      0,
      (sum, meal) => sum + meal.carbs,
    );
    final totalFat = todaysMeals.fold<double>(0, (sum, meal) => sum + meal.fat);

    final updatedUser = state.userModel!.copyWith(
      dailyCalorieConsumed: totalCalories.round(),
      proteinConsumed: totalProtein.round(),
      carbsConsumed: totalCarbs.round(),
      fatConsumed: totalFat.round(),
    );

    emit(state.copyWith(userModel: updatedUser));

    _homeRepository.updateUserData(updatedUser);
  }
}
