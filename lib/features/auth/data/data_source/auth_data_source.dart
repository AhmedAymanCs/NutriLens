import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/features/auth/data/models/user_model.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn({required String email, required String password});

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<void> addDataToFirestore({
    required OnboardingState state,
    required String name,
  });
  Future<void> addUserSession({required UserDataModel userModel});
  Future<UserDataModel> getUserSession();
  Future<void> resetPassword({required String email});
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
  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

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
  Future<void> addDataToFirestore({
    required OnboardingState state,
    required String name,
  }) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        final userModel = UserDataModel(
          uid: user.uid,
          name: name,
          email: user.email ?? "",
          photoURL: user.photoURL,
          gender: state.selectedGenderValue ?? "",
          goal: state.selectedGoalValue ?? "",
          age: state.selectedAgeValue ?? 0,
          height: state.selectedHeightValue ?? "",
          weight: state.selectedWeightValue ?? "",
        );
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection(AppConstants.userCollectionName)
            .doc(user.uid);
        await userDoc.set(userModel.toJson());
        await addUserSession(userModel: userModel);
        
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDataModel> addUserSession({
    required UserDataModel userModel,
  }) async {
    try {
      await secureStorageHelper.saveUserData(jsonEncode(userModel.toJson()));
      await secureStorageHelper.saveData(
        key: AppConstants.userTempSession,
        value: jsonEncode(userModel.toJson()),
      );
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserDataModel> getUserSession() async {
    try {
      final userSession = await secureStorageHelper.getData(
        key: AppConstants.userTempSession,
      );
      UserDataModel userModel = UserDataModel.fromJson(
        jsonDecode(userSession!),
      );
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
