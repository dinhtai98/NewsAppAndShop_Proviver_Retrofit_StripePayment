import 'package:flutter/material.dart';
import 'package:flutter_demo/API/restAPI.dart';
import 'package:flutter_demo/elements/loader.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/style/theme.dart' as Style;
import 'package:dio/dio.dart';

class GetSourceNews {
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  FutureBuilder<ArticleResponse> buildHotNews(BuildContext context,
      String sourceId, Widget child(ArticleResponse data)) {
    return FutureBuilder<ArticleResponse>(
      future: client.getSourceNews(Style.Colors.keyAPI, sourceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child(snapshot.data);
        } else {
          return Center(
            child: buildLoadingWidget(),
          );
        }
      },
    );
  }
}
