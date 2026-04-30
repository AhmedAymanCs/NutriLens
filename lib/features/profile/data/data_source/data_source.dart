import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class ProfileDataSource {
  Future<UserModel> getUserData();
  Future<void> updateUserData(UserModel user);
  Future<void> signOut();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileDataSourceImpl(this._firestore, this._auth);

  @override
  Future<UserModel> getUserData() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("الجلسة انتهت، برجاء تسجيل الدخول مرة أخرى");
    }

    try {
      final uid = user.uid;
      final doc = await _firestore.collection('Users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      } else {
  throw Exception("لم يتم العثور على بيانات المستخدم");
      }
    } catch (e) {
      throw Exception("فشل في جلب البيانات: ${e.toString()}");
    }
  }
  // تجربة
  // @override
  // Future<UserModel> getUserData() async {
  //   try {
  //     final user = _auth.currentUser;

  //     if (user == null) {
  //       return UserModel(
  //         uId: "dummy_id",
  //         name: "Ahmed Abdelghany", //
  //         email: "ahmed@example.com",
  //         photoUrl: null,
  //         streakCount: 24,
  //         isPro: true,
  //         age: 20,
  //         gender: '',
  //         weight: 60,
  //         height: 175,
  //         dailyCalorieGoal: 500,
  //       );
  //     }

  //     final uid = user.uid;
  //     final doc = await _firestore.collection('users').doc(uid).get();

  //     if (doc.exists && doc.data() != null) {
  //       return UserModel.fromJson(doc.data()!);
  //     } else {
  //       return UserModel(
  //         uId: uid,
  //         name: "Ahmed Abdelghany",
  //         email: user.email ?? "",
  //         streakCount: 24,
  //         isPro: true,
  //         age: 55,
  //         gender: '',
  //         weight: 55,
  //         height: 55,
  //         dailyCalorieGoal: 55,
  //       );
  //     }
  //   } catch (e) {
  //     return UserModel(
  //       uId: "error_id",
  //       name: "Guest User",
  //       email: "error@network.com",
  //       streakCount: 0,
  //       isPro: false,
  //       age: 25,
  //       gender: '',
  //       weight: 95,
  //       height: 196,
  //       dailyCalorieGoal: 56,
  //     );
  //   }
  // }

  @override
  Future<void> updateUserData(UserModel user) async {
    await _firestore.collection('Users').doc(user.uid).update(user.toJson());
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
