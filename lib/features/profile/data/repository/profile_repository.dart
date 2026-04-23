import 'package:nutrilens/features/profile/data/data_source/data_source.dart';

abstract class ProfileRepository {}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);
}
