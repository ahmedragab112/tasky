// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTimeModel _$WorkTimeModelFromJson(Map<String, dynamic> json) =>
    WorkTimeModel(
      rounds: json['rounds'] as String?,
      longRestTime: json['longRestTime'] as String?,
      workTime: json['workTime'] as String?,
      id: json['id'] as String?,
      shortRestTime: json['shortRestTime'] as String?,
    );

Map<String, dynamic> _$WorkTimeModelToJson(WorkTimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rounds': instance.rounds,
      'longRestTime': instance.longRestTime,
      'shortRestTime': instance.shortRestTime,
      'workTime': instance.workTime,
    };
