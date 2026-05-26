import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/core/theme/cubit/cubit.dart';
import 'package:nutrilens/features/profile/data/repository/profile_repository.dart';
import 'package:nutrilens/features/profile/logic/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileCubit(this._profileRepository) : super(const ProfileState());

  Future<void> getThemeSettings() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.getThemeSettings();
    result.fold(
      (failure) {
        emit(
          state.copyWith(status: ProfileStatus.failure, errorMessage: failure),
        );
      },
      (isDarkMode) {
        emit(
          state.copyWith(status: ProfileStatus.success, isDarkMode: isDarkMode),
        );
      },
    );
  }

  void toggleDarkMode(BuildContext context) {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
    context.read<ThemeCubit>().toggleTheme();
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
    getThemeSettings();
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
