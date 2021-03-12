import 'package:flutter/material.dart';

class InputSearch with ChangeNotifier {
  String _input = "";
  getInput() => _input;
  void setInput() {
    _input = "";
    notifyListeners();
  }

  void onChanged(String input) {
    _input = input;
    notifyListeners();
  }
}
