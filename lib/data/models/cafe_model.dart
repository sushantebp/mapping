import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'cafe_model.freezed.dart';
part 'cafe_model.g.dart';

@freezed
@HiveType(typeId: 1)
abstract class CafeModel with _$CafeModel {
  factory CafeModel({
    @HiveField(0) required int id,
    @HiveField(1) required double lat,
    @HiveField(2) required double lon,
    @HiveField(3) String? name,
    @HiveField(4) String? cuisine,
    @HiveField(5) String? website,
  }) = _CafeModel;

  factory CafeModel.fromJson(Map<String, dynamic> json) =>
      _$CafeModelFromJson(json);
}
