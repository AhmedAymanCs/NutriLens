import 'dart:convert';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:nutrilens/core/di/service_locator.dart';
import 'package:nutrilens/core/models/user_model.dart';

Future<UserModel?> getLocalUserData() async {
  final currentUserData = await getIt<SecureStorageHelper>().getData(
    key: AppConstants.userSession,
  );
  Map<String, dynamic> userDataSession = jsonDecode(currentUserData!);
  return UserModel.fromFirestore(userDataSession);
}
