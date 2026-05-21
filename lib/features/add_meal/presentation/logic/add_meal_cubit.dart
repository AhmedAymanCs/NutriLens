import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_meal_repository.dart';
import 'package:nutrilens/features/add_meal/presentation/logic/add_meal_state.dart';

class AddMealCubit extends Cubit<AddMealState> {
  final AddMealRepository addMealRepository;
  AddMealCubit(this.addMealRepository) : super(const AddMealState());

  Future<void> getMealElements() async {
    emit(state.copyWith(status: AddMealStatus.loading));
    final result = await addMealRepository.getMealElements();
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (meals) =>
          emit(state.copyWith(status: AddMealStatus.initial, meals: meals)),
    );
  }

  Future<void> saveMeal({required MealModel mealModel, required String mealType}) async {
    emit(state.copyWith(status: AddMealStatus.loading));
    final result = await addMealRepository.saveMeal(
      mealModel: mealModel,
      mealType: mealType,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (_) => emit(state.copyWith(status: AddMealStatus.saveSuccess)),
    );
  }

  Future<void> searchInMeals({required String mealName}) async {
    emit(state.copyWith(status: AddMealStatus.loading));
    final result = await addMealRepository.searchInMeals(
      mealName: mealName,
      meals: state.meals,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (meals) => emit(
        state.copyWith(
          status: AddMealStatus.getSuccess,
          meals: meals,
          meal: meals.first,
        ),
      ),
    );
  }
}
