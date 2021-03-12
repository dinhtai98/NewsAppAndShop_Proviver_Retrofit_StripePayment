

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class InitFlutterLocalNotification {
  static Future<void> init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _selectNotification);
  }

  static Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // DialogUtils.showOkCancelDialog(
    //   title: title,
    //   body: 'Your Order has been updated. Do you want to check it?',
    //   onOK: () {
    //     var jsonMessage = json.decode(payload);
    //     Get.offNamed(MyRouter.home); // Workaround to reload ReceiptDetailScreen when in ReceipDetailScreen
    //     Get.offNamed(
    //       MyRouter.receiptDetail,
    //       arguments: ReceiptDetailScreenArguments(
    //         orderId: jsonMessage['id'],
    //       ),
    //     );
    //   }

    // );

      // Widget _buildDialog(BuildContext context, Item item) {
  //   return new AlertDialog(
  //       content: new Text("Item ${item.itemId} has been updated"),
  //       actions: <Widget>[
  //         new FlatButton(
  //           child: const Text('CLOSE'),
  //           onPressed: () {
  //             Navigator.pop(context, false);
  //           },
  //         ),
  //         new FlatButton(
  //           child: const Text('SHOW'),
  //           onPressed: () {
  //             Navigator.pop(context, true);
  //           },
  //         ),
  //       ]);
  // }


  }

  static Future _selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }

    print('SELECT NOTIFICATION');

    var messageJson = json.decode(payload);

    // locator<GlobalData>().onLaunchFcmMessage = messageJson;

    // Get.offNamed(MyRouter.home); // Workaround to reload ReceiptDetailScreen when in ReceipDetailScreen
    // Get.offNamed(
    //   MyRouter.receiptDetail,
    //   arguments: ReceiptDetailScreenArguments(
    //     orderId: messageJson['id'],
    //   ),
    // );
  }
}
