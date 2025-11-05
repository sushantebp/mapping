part of 'place_cubit.dart';

@freezed
abstract class PlaceState with _$PlaceState {
  const factory PlaceState.initial() = _Initial;
  const factory PlaceState.loading() = _Loading;
  const factory PlaceState.loaded({required PositionModel position}) = _Loaded;
  const factory PlaceState.failure(String message) = _Failure;
}
