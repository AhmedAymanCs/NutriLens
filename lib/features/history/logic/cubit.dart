import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/history/data/repository/history_repository.dart';
import 'package:nutrilens/features/history/logic/state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _historyRepository;
  
  UserModel? _originalHistoryData; 

  HistoryCubit(this._historyRepository)
      : super(HistoryState(
          selectedDate: DateTime.now(),
          focusedDay: DateTime.now(),
        ));

  Future<void> getLocalUserData() async {
    emit(state.copyWith(status: HistoryStatus.loading));
    final result = await _historyRepository.getLocalUserData();
    result.fold(
      (failure) => emit(state.copyWith(status: HistoryStatus.failure, error: failure)),
      (userModel) => emit(state.copyWith(status: HistoryStatus.success, userModel: userModel)),
    );
  }

  Future<void> getRemoteHistoryData(DateTime date) async {
    emit(state.copyWith(status: HistoryStatus.loading, selectedDate: date, focusedDay: date));

    final result = await _historyRepository.getRemoteHistoryData(date);

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
    if (_originalHistoryData == null) return;

    if (filter == StringManager.allMeals) {
      emit(state.copyWith(
        status: HistoryStatus.success, 
        userModel: _originalHistoryData,
      ));
      return;
    }

    final filteredMeals = _originalHistoryData!.todayMeals.where((meal) {
      return meal.mealType.trim().toLowerCase() == filter.trim().toLowerCase();
    }).toList();

    final filteredData = _originalHistoryData!.copyWith(todayMeals: filteredMeals);

    emit(state.copyWith(
      status: HistoryStatus.success, 
      userModel: filteredData, 
    ));
  }
}