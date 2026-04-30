import '../data_source/data_source.dart';
import '../models/user_model.dart';

abstract class ProfileRepository {
  Future<UserModel> getUser();
  Future<void> updateProfile(UserModel user);
  Future<void> signOut();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<UserModel> getUser() async {
    return await _dataSource.getUserData();
  }

  @override
  Future<void> updateProfile(UserModel user) async {
    await _dataSource.updateUserData(user);
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }
}
