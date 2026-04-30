import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_repository.dart';

part 'state.dart';

class AddMealCubit extends Cubit<AddMealState> {
  final AddMealRepository repository;

  AddMealCubit(this.repository) : super(AddMealState());

  void searchMeals(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(meals: [], status: AddMealStatus.initial));
      return;
    }

    emit(state.copyWith(status: AddMealStatus.searching));

    final result = await repository.searchMeals(query);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AddMealStatus.error,
        errorMessage: failure,
      )),
      (mealsList) => emit(state.copyWith(
        status: AddMealStatus.success,
        meals: mealsList,
      )),
    );
  }

  Future<void> addNewMeal(MealModel meal) async {
    emit(state.copyWith(status: AddMealStatus.loading));

    final result = await repository.addMeal(meal);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AddMealStatus.error,
        errorMessage: failure,
      )),
      (_) => emit(state.copyWith(
        status: AddMealStatus.success,
      )),
    );
  }
}