// هنا لازم اعمل ايزر والفولد 
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
    
    final result = await _profileRepository.getUser();
    
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure)),
      (user) => emit(state.copyWith(status: ProfileStatus.success, user: user)),
    );
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    
    final result = await _profileRepository.updateProfile(user: updatedUser);
    
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure)),
      (_) => emit(state.copyWith(status: ProfileStatus.success, user: updatedUser)),
    );
  }

  Future<void> logout() async {
    final result = await _profileRepository.signOut();
    
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure)),
      (_) => emit(state.copyWith(status: ProfileStatus.initial, user: null)),
    );
  }
}