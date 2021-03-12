import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  final String id;
  final String name;
  final String department;
  final String description;
  final String urlImage;
  final String price;

  Product(this.id, this.name, this.department, this.urlImage, this.price, this.description);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
