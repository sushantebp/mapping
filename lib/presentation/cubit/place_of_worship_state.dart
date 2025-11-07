part of 'place_of_worship_cubit.dart';

@freezed
class PlaceOfWorshipState with _$PlaceOfWorshipState {
  const factory PlaceOfWorshipState.initial() = _Initial;
  const factory PlaceOfWorshipState.loading() = _Loading;
  const factory PlaceOfWorshipState.loaded({
    required List<PlaceOfWorshipModel> worshipPlaceList,
  }) = _Loaded;
  const factory PlaceOfWorshipState.failure(String message) = _Failure;
}
