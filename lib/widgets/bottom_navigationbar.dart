import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/style/theme.dart' as Style;

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, bottomNavBarProvider, __) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.grey[100], spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              iconSize: 20,
              unselectedItemColor: Style.Colors.grey,
              unselectedFontSize: 9.5,
              selectedFontSize: 9.5,
              type: BottomNavigationBarType.fixed,
              fixedColor: Style.Colors.mainColor,
              currentIndex: bottomNavBarProvider.getSelected(),
              onTap: bottomNavBarProvider.onItemTapped,
              items: [
                BottomNavigationBarItem(
                  title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("Home",
                          style: TextStyle(fontWeight: FontWeight.w600))),
                  icon: Icon(EvaIcons.homeOutline),
                  activeIcon: Icon(EvaIcons.home),
                ),
                BottomNavigationBarItem(
                  title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("Shop",
                          style: TextStyle(fontWeight: FontWeight.w600))),
                  icon: Icon(EvaIcons.gridOutline),
                  activeIcon: Icon(EvaIcons.grid),
                ),
                BottomNavigationBarItem(
                  title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("Search",
                          style: TextStyle(fontWeight: FontWeight.w600))),
                  icon: Icon(EvaIcons.searchOutline),
                  activeIcon: Icon(EvaIcons.search),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
