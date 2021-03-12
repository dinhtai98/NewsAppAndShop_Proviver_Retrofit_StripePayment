import 'package:flutter/material.dart';

// enum NavBarItem { HOME, SOURCES, SEARCH }

class BottomNavBarProvider with ChangeNotifier {
  // NavBarItem defaultItem = NavBarItem.HOME;
  int _selectedIndex = 1;
  getSelected() => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
