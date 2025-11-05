import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mapping/core/core.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';

part 'place_state.dart';
part 'place_cubit.freezed.dart';

class PlaceCubit extends BaseCubit<PlaceState> {
  final HomeRepository _homeRepository;
  PlaceCubit(this._homeRepository) : super(const _Initial());

  Future<void> searchResult(String query) async {
    emit(const _Loading());
    try {
      final result = await _homeRepository.fetchPlaceInfo(query);
      result.fold(
        (failure) => emit(_Failure(failure.message ?? "Unknown error")),
        (position) => emit(_Loaded(position: position)),
      );
    } catch (e) {
      emit(_Failure('Unexpected error occurred: $e'));
    }
  }
}
