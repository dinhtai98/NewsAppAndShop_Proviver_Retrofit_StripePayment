import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/API/restAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/elements/loader.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/style/theme.dart' as Style;


class GetHotNews {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  FutureBuilder<ArticleResponse> buildHotNews(
      BuildContext context, Widget child(ArticleResponse data)) {
    return FutureBuilder<ArticleResponse>(
      future: client.getHotNews(Style.Colors.keyAPI, "apple", "popularity"),
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