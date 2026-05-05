import 'package:equatable/equatable.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/features/history/data/model/history_data_model.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final String error;
  final HistoryDataModel? historyData;
  final DateTime selectedDate;
  final DateTime focusedDay;
  final String selectedFilter;

  const HistoryState({
    this.status = HistoryStatus.initial,
    this.error = '',
    this.historyData,
    required this.selectedDate,
    required this.focusedDay,
    this.selectedFilter = StringManager.allMeals,
  });

  HistoryState copyWith({
    HistoryStatus? status,
    String? error,
    HistoryDataModel? historyData,
    DateTime? selectedDate,
    DateTime? focusedDay,
    String? selectedFilter,
  }) {
    return HistoryState(
      status: status ?? this.status,
      error: error ?? this.error,
      historyData: historyData ?? this.historyData,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [status, error, historyData, selectedDate, focusedDay, selectedFilter];
}