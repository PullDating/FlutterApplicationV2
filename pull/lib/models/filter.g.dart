// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Filter _$$_FilterFromJson(Map<String, dynamic> json) => _$_Filter(
      men: json['men'] as bool,
      women: json['women'] as bool,
      nonBinary: json['nonBinary'] as bool,
      minAge: json['minAge'] as int,
      maxAge: json['maxAge'] as int,
      minHeight: json['minHeight'] as int,
      maxHeight: json['maxHeight'] as int,
      obese: json['obese'] as bool,
      heavy: json['heavy'] as bool,
      muscular: json['muscular'] as bool,
      average: json['average'] as bool,
      lean: json['lean'] as bool,
      maxDistance: json['maxDistance'] as int,
    );

Map<String, dynamic> _$$_FilterToJson(_$_Filter instance) => <String, dynamic>{
      'men': instance.men,
      'women': instance.women,
      'nonBinary': instance.nonBinary,
      'minAge': instance.minAge,
      'maxAge': instance.maxAge,
      'minHeight': instance.minHeight,
      'maxHeight': instance.maxHeight,
      'obese': instance.obese,
      'heavy': instance.heavy,
      'muscular': instance.muscular,
      'average': instance.average,
      'lean': instance.lean,
      'maxDistance': instance.maxDistance,
    };
