// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) {
  return SourceModel(
    json['id'] as String,
    json['name'] as String,
    json['description'] as String,
    json['url'] as String,
    json['category'] as String,
    json['country'] as String,
    json['language'] as String,
  );
}

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'category': instance.category,
      'country': instance.country,
      'language': instance.language,
    };
