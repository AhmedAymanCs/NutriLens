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
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: failure,
      )),
      (userModel) => emit(state.copyWith(
        status: HomeStatus.success,
        userModel: userModel, 
      )),
    );
  }

  Future<void> getRemoteUserData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    
    final result = await _homeRepository.getRemoteUserData();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: failure,
      )),
      (fetchedUser) {
        
        UserModel userToDisplay = fetchedUser;

        if (userToDisplay.dailyCalorieGoal == 0 || userToDisplay.carbsGoal == 0 || userToDisplay.proteinGoal == 0 || userToDisplay.fatGoal == 0 || userToDisplay.weight > 0) {
          userToDisplay = calculateDailyGoals(userToDisplay);
          
        }

        emit(state.copyWith(
          status: HomeStatus.success,
          userModel: userToDisplay, 
        ));
      },
    );
  }

  UserModel calculateDailyGoals(UserModel user) {
    double bmr;

    if (user.gender.toLowerCase() == 'male') {
      bmr = (10 * user.weight) + (6.25 * user.height) - (5 * user.age) + 5;
    } else {
      bmr = (10 * user.weight) + (6.25 * user.height) - (5 * user.age) - 161;
    }

    double tdee = bmr * 1.2;

    double targetCalories = tdee;
    String currentGoal = user.goal.toLowerCase().trim();

    if (currentGoal.contains('gain') || currentGoal == 'Gain Weight') {
      targetCalories += 500; 
    } else if (currentGoal.contains('lose') || currentGoal == 'Lose Weight'){
      targetCalories -= 500; 
    } 

    double carbs = (targetCalories * 0.50) / 4;
    
    double protein = (targetCalories * 0.30) / 4;
    
    double fats = (targetCalories * 0.20) / 9;

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
}