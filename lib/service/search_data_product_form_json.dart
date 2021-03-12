import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_demo/models/products/product.dart';

class ServiceSearchDataProduct {
  static Future<Product> getData(String name) async {
    String data = await rootBundle.loadString("assets/json/json.json");
    List<Product> list = parseResponse(data);
    for (var x in list) {
      if (x.name == name) {
        return x;
      }
    }
    return null;
  }

  static Future<Product> getDataUseID(String id) async {
    String data = await rootBundle.loadString("assets/json/json.json");
    List<Product> list = parseResponse(data);
    for (var x in list) {
      if (x.id == id) {
        return x;
      }
    }
    return null;
  }

  static List<Product> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
