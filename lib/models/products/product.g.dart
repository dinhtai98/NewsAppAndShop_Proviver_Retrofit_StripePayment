// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'] as String,
    json['name'] as String,
    json['department'] as String,
    json['urlImage'] as String,
    json['price'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'department': instance.department,
      'description': instance.description,
      'urlImage': instance.urlImage,
      'price': instance.price,
    };
