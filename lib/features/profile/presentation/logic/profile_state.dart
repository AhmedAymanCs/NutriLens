import 'package:equatable/equatable.dart';
import 'package:nutrilens/core/models/user_model.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String errorMessage;
  final UserModel? user;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage = '',
    this.user,
  });
  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
