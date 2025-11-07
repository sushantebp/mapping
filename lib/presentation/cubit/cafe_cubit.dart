import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';

part 'cafe_state.dart';
part 'cafe_cubit.freezed.dart';

class CafeCubit extends Cubit<CafeState> {
  final HomeRepository _homeRepository;
  CafeCubit(this._homeRepository) : super(const _Initial());

  Future<void> getCafe() async {
    emit(const _Loading());
    try {
      final result = await _homeRepository.getCafe();
      result.fold(
        (failure) => emit(_Failure(failure.message ?? "Unknown error")),
        (cafeList) => emit(_Loaded(cafeList: cafeList)),
      );
    } catch (e) {
      emit(_Failure('Unexpected error occurred: $e'));
    }
  }
}
