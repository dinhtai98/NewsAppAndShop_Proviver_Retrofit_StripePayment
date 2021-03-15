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
    json['receiver'] as String,
    json['address'] as String,
    json['mail'] as String,
    json['phonenumber'] as String,
    json['typeofpayment'] as String,
    json['ordernote'] as String,
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'idorder': instance.idorder,
      'status': instance.status,
      'receiver': instance.receiver,
      'address': instance.address,
      'mail': instance.mail,
      'phonenumber': instance.phonenumber,
      'typeofpayment': instance.typeofpayment,
      'ordernote': instance.ordernote,
      'cart': instance.cart?.map((e) => e?.toJson())?.toList(),
    };
