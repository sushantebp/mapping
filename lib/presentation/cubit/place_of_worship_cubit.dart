import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';

part 'place_of_worship_state.dart';
part 'place_of_worship_cubit.freezed.dart';

class PlaceOfWorshipCubit extends Cubit<PlaceOfWorshipState> {
  final HomeRepository _homeRepository;
  PlaceOfWorshipCubit(this._homeRepository) : super(const _Initial());

  Future<void> getCafe() async {
    emit(const _Loading());
    try {
      final result = await _homeRepository.getPlaceOfWorship();
      result.fold(
        (failure) => emit(_Failure(failure.message ?? "Unknown error")),
        (worshipPlaceList) => emit(_Loaded(worshipPlaceList: worshipPlaceList)),
      );
    } catch (e) {
      emit(_Failure('Unexpected error occurred: $e'));
    }
  }
}
