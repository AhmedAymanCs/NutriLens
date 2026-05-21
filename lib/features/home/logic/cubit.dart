import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';
import 'package:nutrilens/features/home/data/repository/repositroy.dart';
part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState());

  Future<void> getUserData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _homeRepository.getUserData();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: failure,
      )),
      (userModel) => emit(
        state.copyWith(
          status: HomeStatus.success,
          userModel: userModel,
        ),
      ),
    );
  }


  Future<void> getTodayMeals() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _homeRepository.getTodayMeals();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: failure,
      )),
      (mealModels) => emit(
        state.copyWith(
          status: HomeStatus.success,
          mealModels: mealModels,
        ),
      ),
    );
  }
}
