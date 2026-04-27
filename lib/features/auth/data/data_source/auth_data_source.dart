import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<void> signIn({required String email, required String password});
  Future<void> addDataToFirestore({required User? user});
  // Future<void> addUserSession({required String userSession,
  //   required User user,
  // });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final SecureStorageHelper secureStorageHelper;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firestore,
    this.secureStorageHelper,
  );

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user != null) {
        await user.user?.updateDisplayName(name);
        await user.user?.reload();
        return user;
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addDataToFirestore({required User? user}) async {
    try {
      if (user != null) {
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection(AppConstants.userCollectionName)
            .doc(user.uid);
        await userDoc.set(UserDataModel.fromFirebaseUser(user).toJson());
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<void> addUserSession({required String userSession, required User user}) async {
  //   try {
  //     await secureStorageHelper.clearAll();
  //     await secureStorageHelper.saveUserData(userSession);
  //     await secureStorageHelper.saveData(key: AppConstants.uid, value: user.uid);
  //     await secureStorageHelper.saveData(key: AppConstants.email, value: user.email ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.name, value: user.displayName ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.photoURL, value: user.photoURL ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.gender, value: user. ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.goal, value: user.photoURL ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.age, value: user.photoURL ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.height, value: user.photoURL ?? "");
  //     await secureStorageHelper.saveData(key: AppConstants.weight, value: user.photoURL ?? "");

  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // ServerResponse<Unit> login() async {
  //   try {
  //     await firebaseAuth.signInAnonymously();
  //     return const Right(unit);
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
