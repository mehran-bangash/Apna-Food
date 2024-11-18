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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAF5B-uWAAQ34OJ05r9cm9xSKQm5tzWuKY',
    appId: '1:585666853080:web:1e4d2ed63b11e021247fad',
    messagingSenderId: '585666853080',
    projectId: 'fooddeliveryapp-a9104',
    authDomain: 'fooddeliveryapp-a9104.firebaseapp.com',
    storageBucket: 'fooddeliveryapp-a9104.appspot.com',
    measurementId: 'G-GN85ENC0PX',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCO763Vp5KdrCwOyvpcGZmLKhjIL6mqhTY',
    appId: '1:585666853080:ios:39e26b279cc85c12247fad',
    messagingSenderId: '585666853080',
    projectId: 'fooddeliveryapp-a9104',
    storageBucket: 'fooddeliveryapp-a9104.appspot.com',
    iosBundleId: 'com.example.apnaFood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCO763Vp5KdrCwOyvpcGZmLKhjIL6mqhTY',
    appId: '1:585666853080:ios:39e26b279cc85c12247fad',
    messagingSenderId: '585666853080',
    projectId: 'fooddeliveryapp-a9104',
    storageBucket: 'fooddeliveryapp-a9104.appspot.com',
    iosBundleId: 'com.example.apnaFood',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAF5B-uWAAQ34OJ05r9cm9xSKQm5tzWuKY',
    appId: '1:585666853080:web:08d642a10601ea76247fad',
    messagingSenderId: '585666853080',
    projectId: 'fooddeliveryapp-a9104',
    authDomain: 'fooddeliveryapp-a9104.firebaseapp.com',
    storageBucket: 'fooddeliveryapp-a9104.appspot.com',
    measurementId: 'G-8501XM5QRF',
  );

}