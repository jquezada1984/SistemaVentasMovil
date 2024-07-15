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
    apiKey: 'AIzaSyAZp-ILHulEfYrirxZ5mRyArOA_I9qE_0A',
    appId: '1:411282089411:web:5ce716b28e3ff3fc910976',
    messagingSenderId: '411282089411',
    projectId: 'taxi-ed7f8',
    authDomain: 'taxi-ed7f8.firebaseapp.com',
    databaseURL: 'https://taxi-ed7f8.firebaseio.com',
    storageBucket: 'taxi-ed7f8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqKa8_MlpnFRYeJs0KOKAfLVG74VFJvbQ',
    appId: '1:411282089411:android:f3053c4e74138897910976',
    messagingSenderId: '411282089411',
    projectId: 'taxi-ed7f8',
    databaseURL: 'https://taxi-ed7f8.firebaseio.com',
    storageBucket: 'taxi-ed7f8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAg2vNMP9Et48uwiTyR0etHsEEKCtDeLVA',
    appId: '1:411282089411:ios:3088b64764bd2bf0910976',
    messagingSenderId: '411282089411',
    projectId: 'taxi-ed7f8',
    databaseURL: 'https://taxi-ed7f8.firebaseio.com',
    storageBucket: 'taxi-ed7f8.appspot.com',
    iosBundleId: 'com.example.ventasFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAg2vNMP9Et48uwiTyR0etHsEEKCtDeLVA',
    appId: '1:411282089411:ios:3088b64764bd2bf0910976',
    messagingSenderId: '411282089411',
    projectId: 'taxi-ed7f8',
    databaseURL: 'https://taxi-ed7f8.firebaseio.com',
    storageBucket: 'taxi-ed7f8.appspot.com',
    iosBundleId: 'com.example.ventasFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZp-ILHulEfYrirxZ5mRyArOA_I9qE_0A',
    appId: '1:411282089411:web:6480ccfaa179820c910976',
    messagingSenderId: '411282089411',
    projectId: 'taxi-ed7f8',
    authDomain: 'taxi-ed7f8.firebaseapp.com',
    databaseURL: 'https://taxi-ed7f8.firebaseio.com',
    storageBucket: 'taxi-ed7f8.appspot.com',
  );
}