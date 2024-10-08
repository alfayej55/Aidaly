// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBnH3oOFdT5SYmwseSkoXsrlCCus6a3vSw',
    appId: '1:944226408020:web:d43d7dd1012e90a270ffc1',
    messagingSenderId: '944226408020',
    projectId: 'aidaly-db442',
    authDomain: 'aidaly-db442.firebaseapp.com',
    storageBucket: 'aidaly-db442.appspot.com',
    measurementId: 'G-871FSHW94Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvpQEs2ZK62AQcZhaK57fI0AdE2r5ww8w',
    appId: '1:944226408020:android:2a5ecf5c5423a72f70ffc1',
    messagingSenderId: '944226408020',
    projectId: 'aidaly-db442',
    storageBucket: 'aidaly-db442.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJwC9FEsGWY_QeJ_a1dRIryn_xLc4Ag-o',
    appId: '1:944226408020:ios:d4508d6faa60c57b70ffc1',
    messagingSenderId: '944226408020',
    projectId: 'aidaly-db442',
    storageBucket: 'aidaly-db442.appspot.com',
    iosBundleId: 'com.aidaly.app.aidaly',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJwC9FEsGWY_QeJ_a1dRIryn_xLc4Ag-o',
    appId: '1:944226408020:ios:d4508d6faa60c57b70ffc1',
    messagingSenderId: '944226408020',
    projectId: 'aidaly-db442',
    storageBucket: 'aidaly-db442.appspot.com',
    iosBundleId: 'com.aidaly.app.aidaly',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBnH3oOFdT5SYmwseSkoXsrlCCus6a3vSw',
    appId: '1:944226408020:web:e6c769c20fd7107270ffc1',
    messagingSenderId: '944226408020',
    projectId: 'aidaly-db442',
    authDomain: 'aidaly-db442.firebaseapp.com',
    storageBucket: 'aidaly-db442.appspot.com',
    measurementId: 'G-BCJ9SSSHGJ',
  );
}
