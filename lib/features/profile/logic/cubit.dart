import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/user_model.dart';
import '../data/repository/profile_repository.dart';

part 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileState());

  Future<void> getUserProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _profileRepository.getUser();
      emit(state.copyWith(status: ProfileStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      await _profileRepository.updateProfile(updatedUser);
      emit(state.copyWith(status: ProfileStatus.success, user: updatedUser));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _profileRepository.signOut();
      print("User Logged Out Successfully");
      emit(state.copyWith(status: ProfileStatus.success, user: null));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }
}
