
part of 'cubit.dart';

enum ProfileStatus { initial, loading, success, failure, updating }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? user; 
  final String error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.error = '',
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? user,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user, 
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}