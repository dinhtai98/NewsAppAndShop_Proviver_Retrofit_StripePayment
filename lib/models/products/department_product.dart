import 'package:json_annotation/json_annotation.dart';

part 'department_product.g.dart';

@JsonSerializable(explicitToJson: true)
class DepartmentProduct {
  String id;
  String name;
  DepartmentProduct(
    this.id,
    this.name,
  );

  factory DepartmentProduct.fromJson(Map<String, dynamic> json) =>
      _$DepartmentProductFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentProductToJson(this);
}
