part of 'cubit.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final String error;
  const HistoryState({this.status = HistoryStatus.initial, this.error = ''});
  HistoryState copyWith({HistoryStatus? status, String? error}) {
    return HistoryState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
