import 'package:flutter_demo/models/article.dart';
import 'package:json_annotation/json_annotation.dart';


part 'article_response.g.dart';


@JsonSerializable()
class ArticleResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;
  final String error;

  ArticleResponse(this.articles, this.status, this.totalResults, this.error);
  factory ArticleResponse.fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);

  // ArticleResponse.fromJson(Map<String, dynamic> json)
  //     : articles =
  //           (json["articles"] as List).map((i) => new ArticleModel.fromJson(i)).toList(),
  //       error = "";

  // ArticleResponse.withError(String errorValue)
  //     : articles = List(),
  //       error = errorValue;
}