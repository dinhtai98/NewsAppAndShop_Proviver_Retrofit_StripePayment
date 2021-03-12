import 'package:flutter_demo/models/products/cart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderdetail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  final String idorder;
  final String status;
  final List<Cart> cart;

  OrderDetail(this.idorder, this.status, this.cart);

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
