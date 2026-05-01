


import 'package:equatable/equatable.dart';
import 'package:nutrilens/features/history/data/model/history_data_model.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  
  final HistoryStatus status;
  final String? error;
  final HistoryDataModel? historyData;
  final DateTime selectedDate;
  
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.error,
    this.historyData,
    required this.selectedDate,
  });

  HistoryState copyWith({
    HistoryStatus? status, 
    String? error, 
    HistoryDataModel? historyData,
    DateTime? selectedDate,
  }) {
    return HistoryState(
      status: status ?? this.status,
      error: error ?? this.error,
      selectedDate: selectedDate ?? this.selectedDate,
      historyData: historyData ?? this.historyData,
    );
  }

  @override
  List<Object?> get props => [status, error, historyData, selectedDate];
}
