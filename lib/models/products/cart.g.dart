// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    json['amount'] as int,
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'product': instance.product?.toJson(),
      'amount': instance.amount,
    };
