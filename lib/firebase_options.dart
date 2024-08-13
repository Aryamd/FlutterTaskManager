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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBVs2Gj-vdQOrO912lBsv1FdRKsBnDx_FM',
    appId: '1:140069114031:web:16fec4d08ea02b14b2445a',
    messagingSenderId: '140069114031',
    projectId: 'task-managerv2',
    authDomain: 'task-managerv2.firebaseapp.com',
    storageBucket: 'task-managerv2.appspot.com',
    measurementId: 'G-Z41GXW6Q7E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKu0WpTccs3a6SrxVmAHQq_a2jI-9fLiM',
    appId: '1:140069114031:android:1a90b7afccbf5f92b2445a',
    messagingSenderId: '140069114031',
    projectId: 'task-managerv2',
    storageBucket: 'task-managerv2.appspot.com',
  );
}
