import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapping/data/data.dart';
import 'package:mapping/domain/domain.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState.initial());

  Future<void> fetchPosition() async {
    emit(const HomeState.loading());
    try {
      final result = await _homeRepository.getCurrentLocation();

      result.fold(
        (failure) =>
            emit(HomeState.failure(failure.message ?? 'Unknown error')),
        (position) => emit(HomeState.loaded(position: position)),
      );
    } catch (e) {
      emit(HomeState.failure('Unexpected error occurred: $e'));
    }
  }
}
