import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/models/products/product.dart';

class DepartmentProvider with ChangeNotifier {
  String _nameDepartment = "";
  List<Product> _dataForDepartment = List();
  getNameDepartment() => _nameDepartment;
  getListData() => _dataForDepartment;

  void onChangedNameDepartment(String name) {
    _nameDepartment = name;
    notifyListeners();
  }

  void getDataForDepartment() async {
    String data = await rootBundle.loadString("assets/json/json.json");
    List<Product> list = parseResponse(data);
    _dataForDepartment.clear();
    for (var x in list) {
      if (x.department == _nameDepartment) _dataForDepartment.add(x);
    }
    notifyListeners();
  }


  List<Product> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
