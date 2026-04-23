import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/History/data/repository/History_repository.dart';
part 'state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _historyRepository;
  HistoryCubit(this._historyRepository) : super(const HistoryState());
}
