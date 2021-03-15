import 'package:flutter_demo/models/products/cart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderdetail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  final String idorder;
  final String status;
  final String receiver;
  final String address;
  final String mail;
  final String phonenumber;
  final String typeofpayment;
  final String ordernote;
  final List<Cart> cart;

  OrderDetail(this.idorder, this.status, this.cart, this.receiver, this.address, this.mail, this.phonenumber, this.typeofpayment, this.ordernote);

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
