import 'package:flutter_demo/models/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_response.g.dart';

@JsonSerializable()
class SourceResponse {
  final List<SourceModel> sources;
  final String error;

  SourceResponse(this.sources, this.error);

  
  factory SourceResponse.fromJson(Map<String, dynamic> json) => _$SourceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);

  // SourceResponse.fromJson(Map<String, dynamic> json)
  //     : sources =
  //           (json["sources"] as List).map((i) => new SourceModel.fromJson(i)).toList(),
  //       error = "";

  // SourceResponse.withError(String errorValue)
  //     : sources = List(),
  //       error = errorValue;
}