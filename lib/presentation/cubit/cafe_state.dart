part of 'cafe_cubit.dart';

@freezed
class CafeState with _$CafeState {
  const factory CafeState.initial() = _Initial;
  const factory CafeState.loading() = _Loading;
  const factory CafeState.loaded({required List<CafeModel> cafeList}) = _Loaded;
  const factory CafeState.failure(String message) = _Failure;
}
