import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'place_of_worship_model.freezed.dart';
part 'place_of_worship_model.g.dart';

@freezed
@HiveType(typeId: 2)
abstract class PlaceOfWorshipModel with _$PlaceOfWorshipModel {
  factory PlaceOfWorshipModel({
    @HiveField(0) required int id,
    @HiveField(1) required double lat,
    @HiveField(2) required double lon,
    @HiveField(3) String? name,
    @HiveField(4) String? religion,
    @HiveField(5) String? denomination,
    @HiveField(6) String? website,
  }) = _PlaceOfWorshipModel;

  factory PlaceOfWorshipModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOfWorshipModelFromJson(json);
}
