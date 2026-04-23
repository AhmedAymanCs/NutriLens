import 'package:nutrilens/features/auth/data/data_source/auth_data_source.dart';

abstract class AuthRepository {}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
}
