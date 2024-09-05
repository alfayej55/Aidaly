// import 'dart:convert';
// import 'dart:io';
// import 'package:aidaly/helpers/prefs_helper.dart';
// import 'package:app_settings/app_settings.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import '../main.dart';
// import '../utils/app_constants.dart';
// import 'logger_helpers.dart';
//
//
//
// final log = logger(NotificationHelper);
// FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
// class NotificationHelper {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static Future<void> getFcmToken() async {
//     String? fcmToken = await _firebaseMessaging.getToken();
//     if (fcmToken != null) {
//       PrefsHelper.setString(AppConstants.fcmToken, fcmToken);
//     }
//     print('FCM Token: $fcmToken');
//   }
//
//   //================================> Notification initialize <========================
//
//   static Future<void> init(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//
//
//     //===================> Local notification initialize <==================
//     await initLocalNotification(flutterLocalNotificationsPlugin);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Handle the notification when the app is in the foreground.
//       print('Foreground massage');
//       log.i("onMessage Message : $message");
//       Map<String, dynamic> data = message.data;
//       handleNotificationRedirection(data);
//       NotificationHelper.showNotification(
//           message, flutterLocalNotificationsPlugin, false);
//
//       // if (Platform.isAndroid) {
//       //   NotificationHelper.showNotification(
//       //       message, flutterLocalNotificationsPlugin, false);
//       // }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle the notification when the app is terminated and the user taps on it.
//       // _handleNotificationRedirection(message);
//
//       Map<String, dynamic> data = message.data;
//       handleNotificationRedirection(data);
//       print('Background massage');
//       debugPrint("onMessageOpenedApp Message : $message");
//     });
//
//
//
//
//     // If the app is terminated, this callback will be triggered when the user taps on the notification.
//     // RemoteMessage? initialMessage =
//     //     await FirebaseMessaging.instance.getInitialMessage();
//     // if (initialMessage != null) {
//     //   log.i("Initial Message  : $initialMessage");
//     //   print("Initial Message : $initialMessage");
//     // }
//
//
//
//
//   }
//
//
//
//   static Future<void> initLocalNotification(
//       FlutterLocalNotificationsPlugin fln) async {
//     var initializationSettingsAndroid =
//     const AndroidInitializationSettings('notification_icon');
//     var initializationSettingsIOS = const DarwinInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     await fln.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse? paylod) async {
//         try {
//           Map<String, dynamic> _payloadData;
//           if (paylod != null && paylod.payload!.isNotEmpty) {
//             _payloadData = jsonDecode(paylod.payload!);
//             debugPrint("Initialize Local Notification payload : $_payloadData");
//
//             handleNotificationRedirection(_payloadData);
//           }
//         } catch (e) {}
//         return;
//       },
//     );
//   }
//
//
//   //================================> Notification Permission <========================
//
//   static bool _isPermissionRequestInProgress = false;
//   static Future<void> notificationPermission() async {
//     if (_isPermissionRequestInProgress) {
//       print("Permission request is already in progress. Please wait.");
//       return;
//     }
//
//     _isPermissionRequestInProgress = true;
//
//     try {
//
//       print('Requesting notification permission');
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//
//       NotificationSettings settings =
//       await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: true,
//         criticalAlert: true,
//         provisional: true,
//         sound: true,
//       );
//
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         log.i("User notification permission authorized");
//       } else if (settings.authorizationStatus ==
//           AuthorizationStatus.provisional) {
//         log.i("User notification permission provisional");
//       } else {
//         AppSettings.openAppSettings();
//       }
//       print('Notification permission request completed');
//     } catch (e) {
//       log.e("Error requesting notification permission: $e");
//     } finally {
//       _isPermissionRequestInProgress = false;
//     }
//   }
//
//   // static void notificationPermission() async {
//   //   print('Notification permission');
//   //   await FirebaseMessaging.instance
//   //       .setForegroundNotificationPresentationOptions(
//   //       alert: true, badge: true, sound: true);
//   //   NotificationSettings settings =
//   //   await FirebaseMessaging.instance.requestPermission(
//   //     alert: true,
//   //     announcement: true,
//   //     badge: true,
//   //     carPlay: true,
//   //     criticalAlert: true,
//   //     provisional: true,
//   //     sound: true,
//   //   );
//   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //     log.i("User notification permission authorized");
//   //   } else if (settings.authorizationStatus ==
//   //       AuthorizationStatus.provisional) {
//   //     log.i("User notification permission provisional");
//   //   } else {
//   //     AppSettings.openAppSettings();
//   //   }
//   //   print('Notification permission');
//   // }
//
//   //================================> Show Notification <========================
//   static Future<void> showNotification(RemoteMessage message,
//       FlutterLocalNotificationsPlugin fln, bool data) async {
//     String title;
//     String body;
//     String? image;
//
//     print('NotificationDataShow>>>');
//     if (data) {
//       title = message.data["title"];
//       body = message.data["body"];
//       image =
//       (message.data['image'] != null && message.data['image'].isNotEmpty)
//           ? message.data['image']
//           : null;
//     } else {
//       title = message.notification!.title!;
//       body = message.notification!.body!;
//       if (GetPlatform.isAndroid) {
//         image = ((message.notification!.android!.imageUrl != null &&
//             message.notification!.android!.imageUrl!.isNotEmpty)
//             ? message.notification!.android!.imageUrl
//             : null);
//       } else if (GetPlatform.isIOS) {
//         image = ((message.notification!.apple!.imageUrl != null &&
//             message.notification!.apple!.imageUrl!.isNotEmpty)
//             ? message.notification!.apple!.imageUrl
//             : null);
//       }
//     }
//     if (image != null && image.isNotEmpty) {
//       try {
//         await showBigPictureNotificationHiddenLargeIcon(
//             title, body, message.data, image, fln);
//         log.i("Show Big Picture Notification ");
//       } catch (e) {
//         await showTextNotification(title, body, message.data, fln);
//         log.i("Show  Text Notification ");
//       }
//     } else {
//       await showBigTextNotification(title, body, message.data, fln);
//       log.i("Show Big Text Notification ");
//     }
//   }
//
// //============================> Show Text Notification <==========================
//   static Future<void> showTextNotification(
//       String title,
//       String body,
//       Map<String, dynamic>? notificationBody,
//       FlutterLocalNotificationsPlugin fln) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'notification', // meta-data android value
//       'notification', // meta-data android value
//       playSound: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: "notification_icon",
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//     );
//
//     // var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
//     //     presentAlert: true, presentBadge: true, presentSound: true);
//
//     // var platformChannelSpecifics = NotificationDetails(
//     //   android: androidPlatformChannelSpecifics,
//     //   iOS: iOSPlatformChannelSpecifics,
//     // );
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload:
//         notificationBody != null ? jsonEncode(notificationBody) : null);
//   }
//
// //===========================> Show Big Text Notification <============================
//   static Future<void> showBigTextNotification(
//       String title,
//       String body,
//       Map<String, dynamic>? notificationBody,
//       FlutterLocalNotificationsPlugin fln) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       body,
//       htmlFormatBigText: true,
//       contentTitle: title,
//       htmlFormatContentTitle: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'notification',
//       'notification',
//       importance: Importance.max,
//       styleInformation: bigTextStyleInformation,
//       priority: Priority.max,
//       icon: "notification_icon",
//       playSound: true,
//       sound: const RawResourceAndroidNotificationSound('notification_sound'),
//     );
//     NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload:
//         notificationBody != null ? jsonEncode(notificationBody) : null);
//   }
//
//
//
//
//
// //==========================> Show Big Picture Notification Hidden largeIcon <=============================
//
//   static Future<void> showBigPictureNotificationHiddenLargeIcon(
//       String title,
//       String body,
//       Map<String, dynamic>? notificationBody,
//       String image,
//       FlutterLocalNotificationsPlugin fln) async {
//     final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
//     final String bigPicturePath =
//     await _downloadAndSaveFile(image, 'bigPicture');
//     final BigPictureStyleInformation bigPictureStyleInformation =
//     BigPictureStyleInformation(
//       FilePathAndroidBitmap(bigPicturePath),
//       hideExpandedLargeIcon: true,
//       contentTitle: title,
//       htmlFormatContentTitle: true,
//       summaryText: body,
//       htmlFormatSummaryText: true,
//     );
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'notification',
//       'notification',
//       largeIcon: FilePathAndroidBitmap(largeIconPath),
//       priority: Priority.max,
//       playSound: true,
//       styleInformation: bigPictureStyleInformation,
//       importance: Importance.max,
//       icon: "notification_icon",
//       sound: const RawResourceAndroidNotificationSound('notification_sound'),
//     );
//     final NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload: notificationBody != null ? jsonEncode(notificationBody) : null);
//   }
//
//   static Future<String> _downloadAndSaveFile(
//       String url, String fileName) async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     final http.Response response = await http.get(Uri.parse(url));
//     final File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }
//
// //=============================> On Click Notification Screen Route <=============================
//
//   static void handleNotificationRedirection(Map<String, dynamic> data) {
//     print('NotificationData>>>$data');
//     // Get.toNamed(AppRoutes.videoScreen, parameters: {'url':data['videoUrl']});
//     //Get.toNamed(AppRoutes.videoScreen,);
//   }
//
//   //===============================> Background Notification Service <==========================
//
//   @pragma('vm:entry-point')
//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message,
//       ) async {
//     // await Firebase.initializeApp();
//     // var androidInitialize =
//     //     const AndroidInitializationSettings('notification_icon');
//     // var iOSInitialize = const DarwinInitializationSettings();
//     // var initializationsSettings =
//     //     InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//     // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     //     FlutterLocalNotificationsPlugin();
//     // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//     // NotificationHelper.showNotification(
//     //     message, flutterLocalNotificationsPlugin, false);
//     // await NotificationHelper.showNotification(
//     //     message, flutterLocalNotificationsPlugin, false);
//   }
// }
//
//


import 'package:aidaly/helpers/prefs_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/app_constants.dart';


FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

class NotificationHelper {

   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static Future<void> getFcmToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      PrefsHelper.setString(AppConstants.fcmToken, fcmToken);
    }
    print('FCM Token: $fcmToken');
  }



  //==================Request for permission and Generate FCM token=================
  static init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging messaging = FirebaseMessaging.instance;


    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted permission==================>>>>>>>>>>>>: ${settings.authorizationStatus}');

    String? token = await messaging.getToken();

  //  SharePrefsHelper.setString(SharedPreferenceValue.fcmToken, token!);

    debugPrint('FCM TOKEN <<<<<<<=====>>>>>>> $token');
  }

  //==================Listen Firebase Notification in every State of the app=================

  static firebaseListenNotification({  required BuildContext context}) async {
    FirebaseMessaging.instance.subscribeToTopic('signedInUsers');
//============>>>>>Listen Notification when the app is in foreground state<<<<<<<===========

    FirebaseMessaging.onMessage.listen((message) {
      // debugPrint(
      //     "Firebase onMessage=============================>>>>>>>>>>>>>>>>>>${message.data}");
      //
      //
      initLocalNotification(message: message);

      showTextNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
      );
    });

//============>>>>>Listen Notification when the app is in BackGround state<<<<<<<===========

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //handleMessage(message: message);
    });

//============>>>>>Listen Notification when the app is in Terminated state<<<<<<<===========

    RemoteMessage? terminatedMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (terminatedMessage != null) {
      //handleMessage(message: terminatedMessage);
    }
  }

  //============================Initialize Local Notification=======================

  static Future<void> initLocalNotification(
      {required RemoteMessage message}) async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    fln
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await fln.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? paylod) {
        debugPrint("==================>>>>>>>>>paylod hitted");
        //handleMessage(message: message);
      },
    );
  }


  // static handleMessage({required RemoteMessage message}) {
  //   Map<String, dynamic> data = message.data;
  //
  //   String type = data["type"];
  //
  //   if (type == "inbox") {
  //     SenderUser senderInfo =
  //     SenderUser.fromJson(jsonDecode(data["senderUser"]));
  //
  //     MessageSent messageInfo =
  //     MessageSent.fromJson(jsonDecode(data["messageSent"]));
  //     Get.toNamed(AppRoute.inbox, arguments: [
  //       senderInfo.name,
  //       senderInfo.photo![0].publicFileUrl,
  //       messageInfo.sender
  //     ], parameters: {
  //       "chatId": messageInfo.chat!
  //     });
  //   } else if (type == "matchRequest") {
  //     Get.toNamed(AppRoute.matchRequest);
  //   }
  // }

// <-------------------------- Show Text Notification  --------------------------->
  static Future<void> showTextNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification', // meta-data android value
      'notification', // meta-data android value
      playSound: true,
      importance: Importance.low,
      priority: Priority.low,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}