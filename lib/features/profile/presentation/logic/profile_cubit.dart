import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/profile/data/repository/profile_repository.dart';
import 'package:nutrilens/features/profile/presentation/logic/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileCubit(this._profileRepository) : super(const ProfileState());

  void toggleDarkMode() {
    emit(
      state.copyWith(
        isDarkMode: !state.isDarkMode,
        status: ProfileStatus.success,
      ),
    );
  }

  void toggleNotification() {
    emit(
      state.copyWith(
        isNotificationEnabled: !state.isNotificationEnabled,
        status: ProfileStatus.success,
      ),
    );
  }

  Future<void> getProfileData() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.getUserProfile();
    result.fold(
      (failure) {
        emit(
          state.copyWith(status: ProfileStatus.failure, errorMessage: failure),
        );
      },
      (user) {
        emit(state.copyWith(status: ProfileStatus.success, user: user));
      },
    );
  }

  Future<void> editProfile(UserModel user) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.editProfile(user);
    result.fold(
      (failure) {
        emit(
          state.copyWith(status: ProfileStatus.failure, errorMessage: failure),
        );
      },
      (_) {
        emit(state.copyWith(status: ProfileStatus.success, user: user));
      },
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.logout();
    result.fold(
      (failure) {
        emit(
          state.copyWith(status: ProfileStatus.failure, errorMessage: failure),
        );
      },
      (_) {
        emit(state.copyWith(status: ProfileStatus.signOutSuccess, user: null));
      },
    );
  }
}
