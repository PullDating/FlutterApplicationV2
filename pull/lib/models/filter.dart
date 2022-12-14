import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:pull/functions/json.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'filter.freezed.dart';
// optional: Since our profile class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'filter.g.dart';

@freezed
class Filter with _$Filter {
  factory Filter({
    required bool genderMan,
    required bool genderWoman,
    required bool genderNonBinary,
    required int minAge,
    required int maxAge,
    required int minHeight,
    required int maxHeight,
    required bool btObese,
    required bool btHeavy,
    required bool btMuscular,
    required bool btAverage,
    required bool btLean,
    ///max distance to the other user in meters
    required int maxDistance,
  }) = _Filter;

factory Filter.fromJson(Map<String, Object?> json)
=> _$FilterFromJson(filterTypeConversion(json));
}

