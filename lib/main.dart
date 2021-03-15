import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/bottom_navbar_provider.dart'; 
import 'package:flutter_demo/provider/input_search_provider.dart';
import 'package:flutter_demo/provider/provider_shop/cart_products_provider.dart';
import 'package:flutter_demo/provider/provider_shop/department_provider.dart';
import 'package:flutter_demo/widgets/route/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/service/connectivity_service.dart';

import 'dart:async';

Future<void> main() async {
  _enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (_) => ConnectivityService().connectionStatusController.stream,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavBarProvider>(
              create: (context) => BottomNavBarProvider()),
          ChangeNotifierProvider<InputSearch>(
              create: (context) => InputSearch()),
          ChangeNotifierProvider<CartsProvider>(
              create: (context) => CartsProvider()),
          ChangeNotifierProvider<DepartmentProvider>(
              create: (context) => DepartmentProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: PushMessagingExample(),
        ),
      ),
    );
  }
}
