// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkIzoC3_vplKLepSgEfNev4-GE0QXNyYI',
    appId: '1:72010274266:android:3a2a557a514be9ceb35ce3',
    messagingSenderId: '72010274266',
    projectId: 'funconnect-cd02c',
    storageBucket: 'funconnect-cd02c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDD6I7TgzwUY4T1eOfwdNQGfziPOusrWYg',
    appId: '1:72010274266:ios:85678643e808a6b8b35ce3',
    messagingSenderId: '72010274266',
    projectId: 'funconnect-cd02c',
    storageBucket: 'funconnect-cd02c.appspot.com',
    androidClientId:
        '72010274266-6drs994dl4a00k83jfbf6njtf6phtq4e.apps.googleusercontent.com',
    iosClientId:
        '72010274266-vosimccjbt4dj700ots582hg6i5br0ft.apps.googleusercontent.com',
    iosBundleId: 'com.funconnect.app',
  );
}
