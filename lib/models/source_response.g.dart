// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceResponse _$SourceResponseFromJson(Map<String, dynamic> json) {
  return SourceResponse(
    (json['sources'] as List)
        ?.map((e) =>
            e == null ? null : SourceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['error'] as String,
  );
}

Map<String, dynamic> _$SourceResponseToJson(SourceResponse instance) =>
    <String, dynamic>{
      'sources': instance.sources,
      'error': instance.error,
    };
