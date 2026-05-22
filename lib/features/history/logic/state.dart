import 'package:equatable/equatable.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/models/user_model.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final String error;
  final List<MealModel> mealModels;
  final UserModel? userModel;
  final DateTime selectedDate;
  final DateTime focusedDay;
  final String selectedFilter;

  const HistoryState({
    this.status = HistoryStatus.initial,
    this.error = '',
    this.mealModels = const [],
    this.userModel,
    required this.selectedDate,
    required this.focusedDay,
    this.selectedFilter = StringManager.allMeals,
  });

  HistoryState copyWith({
    HistoryStatus? status,
    String? error,
    UserModel? userModel,
    List<MealModel>? mealModels,
    DateTime? selectedDate,
    DateTime? focusedDay,
    String? selectedFilter,
  }) {
    return HistoryState(
      status: status ?? this.status,
      error: error ?? this.error,
      mealModels: mealModels ?? this.mealModels,
      userModel: userModel ?? this.userModel,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [status, error, mealModels, userModel, selectedDate, focusedDay, selectedFilter];
}