import 'package:flutter/material.dart';
import 'package:flutter_demo/API/restAPIProducts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/elements/loader.dart';
import 'package:flutter_demo/models/products/product.dart';

class GetProducts {
  final client =
      RestClientProducts(Dio(BaseOptions(contentType: "application/json")));
  FutureBuilder<List<Product>> getProducts(
      BuildContext context, Widget child(List<Product> data)) {
    return FutureBuilder<List<Product>>(
      future: client.getProducts(),
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
