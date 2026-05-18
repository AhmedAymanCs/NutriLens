import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart'; // تأكد من مسار الـ UserModel
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

  Future<void> fetchHistory(DateTime date) async {
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
    if (_originalHistoryData == null) return;

    if (filter == "All Meals") {
      emit(state.copyWith(
        status: HistoryStatus.success, 
        historyData: _originalHistoryData,
      ));
      return;
    }

    final filteredMeals = _originalHistoryData!.todayMeals.where((meal) {
      return meal.mealType.trim().toLowerCase() == filter.trim().toLowerCase();
    }).toList();

    final filteredData = _originalHistoryData!.copyWith(todayMeals: filteredMeals);

    emit(state.copyWith(
      status: HistoryStatus.success, 
      historyData: filteredData,
    ));
  }
}