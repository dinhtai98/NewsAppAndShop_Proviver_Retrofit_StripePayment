import 'dart:convert';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/product.dart';
import 'package:flutter_demo/provider/bottom_navbar_provider.dart';
import 'package:flutter_demo/screens/tabs/home_screen.dart';
import 'package:flutter_demo/screens/tabs/search_screen.dart';
import 'package:flutter_demo/screens/tabs/sources_screen.dart';
import 'package:flutter_demo/service/search_data_product_form_json.dart';
import 'package:flutter_demo/widgets/bottom_navigationbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_demo/screens/shop/description_products.dart';
import 'package:flutter_demo/firebase/init_flutter_local_notification.dart';

// String _homeScreenText = "Waiting for token...";

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _homeScreenText = "Waiting for token...";
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final String pagechooser = message['data']['status'];
    print(message);
    if (message['data']['status'] == "/descriptionProduct") {
      Future.delayed(Duration.zero, () async {
        await ServiceSearchDataProduct.getDataUseID(message['data']['id'])
            .then((value) {
          value != null
              ? Navigator.of(context).pushNamed(
                  pagechooser,
                  arguments: DescriptionProductScreenArguments(product: value),
                )
              : print("sai");
        });
      });
    } else {
      Navigator.of(context).pushNamed(
        pagechooser,
      );
    }
  }

  //DIALOGUE
  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, message),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

// WIDGET WHICH IS GOING TO BE CALLED IN THE ABOVE DIALOGUE
  Widget _buildDialog(BuildContext context, Map<String, dynamic> message) {
    return new AlertDialog(
        content: new Text(
            "${message['notification']['body']} is getting a ${message['notification']['title']}"),
        actions: <Widget>[
          new FlatButton(
            child: const Text('CLOSE'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          new FlatButton(
            child: const Text('SHOW'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ]);
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    // initStartups();
    _firebaseMessaging.configure(
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
      onMessage: (Map<String, dynamic> message) async {
        _showItemDialog(message);
      },
    );

//GETTING TOKEN FOR TESTING MANUALY
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        // ignore: unawaited_futures
        // Navigator.pushNamed(context, deepLink.path);
        Navigator.of(context).pushNamed(deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      // ignore: unawaited_futures
      print(deepLink.path);
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('main build');
    return Scaffold(
      body: SafeArea(child: Consumer<BottomNavBarProvider>(
        builder: (_, bottomNavBarProvider, __) {
          return bottomNavBarProvider.getSelected() == 0
              ? HomeScreen()
              : bottomNavBarProvider.getSelected() == 1
                  ? SourceScreen()
                  : SearchScreen();
        },
      )),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  var dataMessage = message['data'];

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'orderStatusChannel',
    'Order Status Channel',
    'Order Status Channel',
    importance: Importance.max,
    priority: Priority.max,
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    dataMessage['msgTitle'],
    dataMessage['msgBody'],
    platformChannelSpecifics,
    payload: jsonEncode(dataMessage),
  );
}
