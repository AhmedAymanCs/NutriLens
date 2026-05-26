import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/models/user_model.dart';

abstract class ProfileDataSource {
  Future<UserModel> getUserProfile();
  Future<void> logout();
  Future<void> editProfile(UserModel user);
  Future<bool> getThemeSettings();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final SecureStorageHelper storage;

  ProfileDataSourceImpl({
    required this.firestore,
    required this.storage,
    required this.auth,
  });

  @override
  Future<UserModel> getUserProfile() async {
    final userData = await storage.getData(key: AppConstants.userSession);
    Map<String, dynamic> userDataJson = jsonDecode(userData!);
    return UserModel.fromFirestore(userDataJson);
  }

  @override
  Future<bool> getThemeSettings() async {
    final themeSettings = await storage.getData(
      key: AppConstants.themeStorageKey,
    );
    return themeSettings == 'light' || themeSettings == null;
  }

  @override
  Future<void> editProfile(UserModel user) async {
    await storage.clearAll();
    await storage.saveData(
      key: AppConstants.userTempSession,
      value: jsonEncode(user.toJson()),
    );
    await storage.saveUserData(jsonEncode(user.toJson()));
    await firestore
        .collection(AppConstants.userCollectionName)
        .doc(auth.currentUser!.uid)
        .set(user.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
