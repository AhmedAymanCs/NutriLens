import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/utils/typedef.dart';
import 'package:nutrilens/features/auth/data/data_source/auth_data_source.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/auth/data/models/user_params_models.dart';

abstract class AuthRepository {
  ServerResponse<UserModel> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  ServerResponse<UserModel> signUp({
    required RegisterParamsModels params,
    required UserOnboardingParamsModel userDataParams,
  });

  ServerResponse<Unit> resetPassword({required String email});
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final FirebaseFirestore firestore;
  final SecureStorageHelper secureStorageHelper;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.firestore,
    required this.secureStorageHelper,
  });

  @override
  ServerResponse<UserModel> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      UserCredential userCredential = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        final userDoc = await firestore
            .collection(AppConstants.userCollectionName)
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          final userModel = UserModel.fromFirestore({
            ...userDoc.data()!,
            'uid': userDoc.id,
          });

          if (rememberMe) {
            await secureStorageHelper.deleteData(
              key: AppConstants.userTempSession,
            );
            String sessionData = jsonEncode(userModel.toJson());
            log("sessionData ==>$sessionData");
            await secureStorageHelper.saveData(
              key: AppConstants.userTempSession,
              value: sessionData,
            );
          }

          return Right(userModel);
        } else {
          return const Left("User data record not found in database");
        }
      }
      return const Left("Authentication failed");
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        return const Left("Invalid Email or Password");
      } else {
        return Left(e.code);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<UserModel> signUp({
    required RegisterParamsModels params,
    required UserOnboardingParamsModel userDataParams,
  }) async {
    try {
      UserCredential user = await authRemoteDataSource.signUp(params: params);
      if (user.user == null) return const Left("Authentication failed");
      final currentUser = UserModel.fromFirebaseAuth(user.user!, params.name);
      final userModel = UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.name,
        photoURL: currentUser.photoURL,
        gender: userDataParams.gender,
        goal: userDataParams.goal,
        age: userDataParams.age,
        height: userDataParams.height,
        weight: userDataParams.weight,
      );
      DocumentReference userDoc = firestore
          .collection(AppConstants.userCollectionName)
          .doc(user.user!.uid);
      await userDoc.set(userModel.toJson());
      await secureStorageHelper.saveUserData(jsonEncode(userModel.toJson()));
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> resetPassword({required String email}) async {
    try {
      await authRemoteDataSource.resetPassword(email: email.trim());
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
