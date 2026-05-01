import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/history/data/repository/history_repository.dart';
import 'package:nutrilens/features/history/logic/state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _historyRepository;
  HistoryCubit(this._historyRepository) : super(HistoryState(selectedDate: DateTime.now()));

  Future<void> fetchHistory(DateTime date) async {
    emit(state.copyWith(status: HistoryStatus.loading, selectedDate: date));
    
    final result = await _historyRepository.getHistoryByDate(date);
    
    result.fold(
      (error) => emit(state.copyWith(status: HistoryStatus.failure, error: error)),
      (data) => emit(state.copyWith(status: HistoryStatus.success, historyData: data)),
    );
  }
}
