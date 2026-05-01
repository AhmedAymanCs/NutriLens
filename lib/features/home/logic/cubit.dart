import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/home/data/model/home_data_model.dart';
import 'package:nutrilens/features/home/data/repository/repositroy.dart';
part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState());

  Future<void> getHomeData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _homeRepository.getHomeData();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: failure,
      )),
      (homeDataModel) => emit(
        state.copyWith(
          status: HomeStatus.success,
          homeDataModel: homeDataModel,
        ),
      ),
    );
  }
}
