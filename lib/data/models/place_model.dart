import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
abstract class PlaceModel with _$PlaceModel {
  const factory PlaceModel({
    @JsonKey(name: 'place_id') required int placeId,
    required String licence,
    @JsonKey(name: 'osm_type') required String osmType,
    @JsonKey(name: 'osm_id') required int osmId,
    required String lat,
    required String lon,
    required String category,
    required String type,
    @JsonKey(name: 'place_rank') required int placeRank,
    required double importance,
    required String addresstype,
    required String name,
    @JsonKey(name: 'display_name') required String displayName,
    required List<String> boundingbox,
  }) = _Place;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceFromJson(json);
}
