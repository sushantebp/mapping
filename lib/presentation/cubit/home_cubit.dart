import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

// get lat and lon from placecubit and override here

class HomeCubit extends BaseCubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState.initial());

  Future<void> fetchPosition() async {
    emit(const HomeState.loading());
    try {
      final result = await _homeRepository.getCurrentLocation();

      result.fold(
        (failure) => emit(_Failure(failure.message ?? 'Unknown error')),
        (position) => emit(_Loaded(position: position)),
      );
    } catch (e) {
      emit(_Failure('Unexpected error occurred: $e'));
    }
  }

  void updatePosition(PositionModel position) {
    emit(_Loaded(position: position));
  }
}
