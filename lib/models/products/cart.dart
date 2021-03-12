import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_demo/models/products/product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  Product product;
  int amount;
  // String urlImage;

  Cart(this.product, this.amount,);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
