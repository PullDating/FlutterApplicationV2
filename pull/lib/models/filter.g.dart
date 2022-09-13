// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Filter _$$_FilterFromJson(Map<String, dynamic> json) => _$_Filter(
      genderMan: json['genderMan'] as bool,
      genderWoman: json['genderWoman'] as bool,
      genderNonBinary: json['genderNonBinary'] as bool,
      minAge: json['minAge'] as int,
      maxAge: json['maxAge'] as int,
      minHeight: json['minHeight'] as int,
      maxHeight: json['maxHeight'] as int,
      btObese: json['btObese'] as bool,
      btHeavy: json['btHeavy'] as bool,
      btMuscular: json['btMuscular'] as bool,
      btAverage: json['btAverage'] as bool,
      btLean: json['btLean'] as bool,
      maxDistance: json['maxDistance'] as int,
    );

Map<String, dynamic> _$$_FilterToJson(_$_Filter instance) => <String, dynamic>{
      'genderMan': instance.genderMan,
      'genderWoman': instance.genderWoman,
      'genderNonBinary': instance.genderNonBinary,
      'minAge': instance.minAge,
      'maxAge': instance.maxAge,
      'minHeight': instance.minHeight,
      'maxHeight': instance.maxHeight,
      'btObese': instance.btObese,
      'btHeavy': instance.btHeavy,
      'btMuscular': instance.btMuscular,
      'btAverage': instance.btAverage,
      'btLean': instance.btLean,
      'maxDistance': instance.maxDistance,
    };
