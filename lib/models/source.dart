import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceModel {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String country;
  final String language;

  SourceModel(this.id, this.name, this.description, this.url, this.category, this.country, this.language);

  factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}