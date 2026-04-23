import 'package:nutrilens/features/history/data/data_source/data_source.dart';

abstract class HistoryRepository {}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _dataSource;

  HistoryRepositoryImpl(this._dataSource);
}
