import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp({required RegisterParamsModels params});
  Future<void> resetPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  @override
  Future<UserCredential> signUp({required RegisterParamsModels params}) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email.trim(),
      password: params.password.trim(),
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }
}
