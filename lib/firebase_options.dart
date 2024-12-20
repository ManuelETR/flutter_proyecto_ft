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
    apiKey: 'AIzaSyD5I1aa7AVcwjvwwoTzmRS_6nxIj_iHMx8',
    appId: '1:1029343581609:web:fdcf9881c9c46f174860b8',
    messagingSenderId: '1029343581609',
    projectId: 'multiserviciostoledo-8574b',
    authDomain: 'multiserviciostoledo-8574b.firebaseapp.com',
    storageBucket: 'multiserviciostoledo-8574b.firebasestorage.app',
    measurementId: 'G-VPT9PHJX43',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQydDhXRkcxphR86k6iapvvBrzt0lYHw8',
    appId: '1:1029343581609:android:e58d8f909d9e5af54860b8',
    messagingSenderId: '1029343581609',
    projectId: 'multiserviciostoledo-8574b',
    storageBucket: 'multiserviciostoledo-8574b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJbVKUbtcIf-A4R6LkT1P5YPO6KhL2BVo',
    appId: '1:1029343581609:ios:e8c0d91c7ac23cb24860b8',
    messagingSenderId: '1029343581609',
    projectId: 'multiserviciostoledo-8574b',
    storageBucket: 'multiserviciostoledo-8574b.firebasestorage.app',
    iosBundleId: 'com.example.flutterProyectoFt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJbVKUbtcIf-A4R6LkT1P5YPO6KhL2BVo',
    appId: '1:1029343581609:ios:e8c0d91c7ac23cb24860b8',
    messagingSenderId: '1029343581609',
    projectId: 'multiserviciostoledo-8574b',
    storageBucket: 'multiserviciostoledo-8574b.firebasestorage.app',
    iosBundleId: 'com.example.flutterProyectoFt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5I1aa7AVcwjvwwoTzmRS_6nxIj_iHMx8',
    appId: '1:1029343581609:web:ddec20d2e8253b964860b8',
    messagingSenderId: '1029343581609',
    projectId: 'multiserviciostoledo-8574b',
    authDomain: 'multiserviciostoledo-8574b.firebaseapp.com',
    storageBucket: 'multiserviciostoledo-8574b.firebasestorage.app',
    measurementId: 'G-ELCDR2N945',
  );
}
