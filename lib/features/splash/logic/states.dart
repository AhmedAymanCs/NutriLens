import 'package:nutrilens/core/models/user_model.dart';

class SplashStates {}

class SplashInitialState extends SplashStates {}

class SplashLoadingState extends SplashStates {}

class SplashLoginState extends SplashStates {}

class SplashAuthenticatedState extends SplashStates {
  UserModel userModel;
  SplashAuthenticatedState(this.userModel);
}

class SplashErrorState extends SplashStates {
  final String error;

  SplashErrorState(this.error);
}
