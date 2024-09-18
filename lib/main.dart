import 'package:aidaly/helpers/system_style.dart';
import 'package:aidaly/service/socket_maneger.dart';
import 'package:aidaly/themes/dark_theme.dart';
import 'package:aidaly/themes/light_theme.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_constants.dart';
import 'package:aidaly/utils/message.dart';
import 'package:aidaly/views/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';


import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart';
import 'helpers/di.dart' as di;
import 'helpers/prefs_helper.dart';
import 'helpers/push_notification_helpers.dart';
import 'helpers/route.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  Stripe.publishableKey=dotenv.env["STRIPE_PUBLISH_KEY"]!;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';

  await Stripe.instance.applySettings();
  await  di.init();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Socket
  SocketApi.init();



  /// Firebase push notification Section
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
      }
      print('Call Firebase Init');
      await NotificationHelper.init();
      // await NotificationHelper.init(flutterLocalNotificationsPlugin);
      // FirebaseMessaging.onBackgroundMessage(NotificationHelper.firebaseMessagingBackgroundHandler);

    }
  }catch(e) {}
   NotificationHelper.getFcmToken();

  /// Languase

  Map<String, Map<String, String>> _languages = await di.init();
  runApp( MyApp(languages:_languages,));

}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  void setStatus(String status) async {
    var driverId=await PrefsHelper.getString(AppConstants.driverId);
    print("driverId: $driverId");

    var body={
      "id":driverId,
      "status":status
    };

    debugPrint('bodyTest>>$body');
    SocketApi.emit('userActive',body);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        setStatus('active');
      });

      print("userOnline: online");

    } else {
      setState(() {
        setStatus('inactive');
      });
      print("userOffline : offline");
    }

    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_ , child) {
              return GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                // theme: themeController.darkTheme ? dark(): light(),
                theme: light(),
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: widget.languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
                getPages: AppRoutes.page,
                initialRoute: AppRoutes.splashScreen,

              );

            }
        );
      }
      );

    }
    );

  }
}




