import 'package:equatable/equatable.dart';
import 'package:nutrilens/core/models/user_model.dart';

enum ProfileStatus { initial, loading, success, failure, signOutSuccess }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String errorMessage;
  final bool isDarkMode, isNotificationEnabled;
  final UserModel? user;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage = '',
    this.isDarkMode = false,
    this.isNotificationEnabled = false,

    this.user,
  });
  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    bool? isDarkMode,
    bool? isNotificationEnabled,
    UserModel? user,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,

      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    isDarkMode,
    isNotificationEnabled,
    user,
  ];
}
