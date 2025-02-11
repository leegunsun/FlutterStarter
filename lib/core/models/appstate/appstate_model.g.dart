// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appstate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppStatus _$AppStatusFromJson(Map<String, dynamic> json) => AppStatus(
      currentVersion: json['currentVersion'] as String,
      isForcedUpdate: json['isForcedUpdate'] as bool,
      isServerMaintenance: json['isServerMaintenance'] as bool,
    );

Map<String, dynamic> _$AppStatusToJson(AppStatus instance) => <String, dynamic>{
      'currentVersion': instance.currentVersion,
      'isForcedUpdate': instance.isForcedUpdate,
      'isServerMaintenance': instance.isServerMaintenance,
    };
