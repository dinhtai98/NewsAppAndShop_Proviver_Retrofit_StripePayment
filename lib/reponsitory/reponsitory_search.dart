import 'package:flutter/material.dart';
import 'package:flutter_demo/API/restAPI.dart';
import 'package:flutter_demo/elements/loader.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/style/theme.dart' as Style;
import 'package:dio/dio.dart';

class GetSearch {
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  FutureBuilder<ArticleResponse> search(
      String input, Widget child(ArticleResponse data)) {
    return input == ""
        ? FutureBuilder<ArticleResponse>(
            future: client.search(Style.Colors.keyAPI, "a", "tét"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return child(snapshot.data);
              } else {
                return Center(
                  child: buildLoadingWidget(),
                );
              }
            },
          )
        : FutureBuilder<ArticleResponse>(
            future: client.search(Style.Colors.keyAPI, input, "popularity"),
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
