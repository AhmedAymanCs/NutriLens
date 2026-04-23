import 'package:nutrilens/features/home/data/data_source/data_source.dart';

abstract class HomeRepository {}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);
}
