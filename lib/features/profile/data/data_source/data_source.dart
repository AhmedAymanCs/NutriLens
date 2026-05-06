import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserData();
  Future<void> updateUserData({required UserModel user});
  Future<void> signOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<UserModel> getUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("الجلسة انتهت، برجاء تسجيل الدخول مرة أخرى");
      }
      final doc = await _firestore
          .collection(AppConstants.userCollectionName)
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      } else {
        throw Exception("لم يتم العثور على بيانات المستخدم");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserData({required UserModel user}) async {
    try {
      await _firestore
          .collection(AppConstants.userCollectionName)
          .doc(user.uid)
          .update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}