import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrilens/core/constants/app_constants.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final FlutterSecureStorage _storage;

  ThemeCubit(this._storage) : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await _storage.read(key: AppConstants.themeStorageKey);
    emit(theme == 'dark' ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await _storage.write(
      key: AppConstants.themeStorageKey,
      value: newTheme == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(newTheme);
  }
}
