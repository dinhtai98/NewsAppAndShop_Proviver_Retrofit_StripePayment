// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    json['idorder'] as String,
    json['status'] as String,
    (json['cart'] as List)
        ?.map(
            (e) => e == null ? null : Cart.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'idorder': instance.idorder,
      'status': instance.status,
      'cart': instance.cart?.map((e) => e?.toJson())?.toList(),
    };
