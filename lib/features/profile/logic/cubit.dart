import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/profile/data/repository/profile_repository.dart';
part 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileCubit(this._profileRepository) : super(const ProfileState());
}
