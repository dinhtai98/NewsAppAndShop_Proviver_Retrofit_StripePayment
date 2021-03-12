import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/API/restAPI.dart';
import 'package:flutter_demo/elements/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/models/source_response.dart';
import 'package:flutter_demo/style/theme.dart' as Style;

class GetTopChannels {
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  FutureBuilder<SourceResponse> buildTopChannels(
      BuildContext context, Widget child(SourceResponse data)) {
    return FutureBuilder<SourceResponse>(
      future: client.getSources(Style.Colors.keyAPI, "en", "us"),
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
