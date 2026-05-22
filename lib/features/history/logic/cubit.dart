import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/features/history/data/repository/history_repository.dart';
import 'package:nutrilens/features/history/logic/state.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _historyRepository;
  
  List<MealModel> _originalHistoryData = []; 

  HistoryCubit(this._historyRepository)
      : super(HistoryState(
          selectedDate: DateTime.now(),
          focusedDay: DateTime.now(),
        ));

  Future<void> getUserData() async {
    emit(state.copyWith(status: HistoryStatus.loading));
    final result = await _historyRepository.getUserData();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HistoryStatus.failure,
        error: failure,
      )),
      (userModel) => emit(
        state.copyWith(
          status: HistoryStatus.success,
          userModel: userModel,
        ),
      ),
    );
  }

  Future<void> getHistoryByDate(DateTime date) async {
    emit(state.copyWith(status: HistoryStatus.loading, selectedDate: date, focusedDay: date));

    final result = await _historyRepository.getHistoryByDate(date);

    result.fold(
      (error) => emit(state.copyWith(status: HistoryStatus.failure, error: error)),
      (data) {
        _originalHistoryData = data;
        
        _applyFilter(state.selectedFilter); 
      },
    );
  }

  void updateFilter(String filter) {
    emit(state.copyWith(selectedFilter: filter));
    _applyFilter(filter);
  }

  void _applyFilter(String filter) {
    if (filter == StringManager.allMeals) {
      emit(state.copyWith(
        status: HistoryStatus.success, 
        mealModels: _originalHistoryData,
      ));
      return;
    }

    final filteredMeals = _originalHistoryData.where((meal) {
      return meal.mealType.trim().toLowerCase() == filter.trim().toLowerCase();
    }).toList();

    emit(state.copyWith(
      status: HistoryStatus.success, 
      mealModels: filteredMeals, 
    ));
  }
}