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
    apiKey: 'AIzaSyBGY9uSJR6rQdfv33qm4sEw61nTTnT06Kk',
    appId: '1:776135688708:web:60f7666b32785db8866b51',
    messagingSenderId: '776135688708',
    projectId: 'aquo-f9d38',
    authDomain: 'aquo-f9d38.firebaseapp.com',
    databaseURL: 'https://aquo-f9d38-default-rtdb.firebaseio.com',
    storageBucket: 'aquo-f9d38.appspot.com',
    measurementId: 'G-PRH5PWHGM4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCb5AUJ8G3k9ZrXUXg3iiw17JVOJ6nq3lU',
    appId: '1:776135688708:android:849b1ac12c901f9b866b51',
    messagingSenderId: '776135688708',
    projectId: 'aquo-f9d38',
    databaseURL: 'https://aquo-f9d38-default-rtdb.firebaseio.com',
    storageBucket: 'aquo-f9d38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6ccW7PgPQ7tMALtvS0aJAQmDmMm74gS0',
    appId: '1:776135688708:ios:a62aede13e98e3de866b51',
    messagingSenderId: '776135688708',
    projectId: 'aquo-f9d38',
    databaseURL: 'https://aquo-f9d38-default-rtdb.firebaseio.com',
    storageBucket: 'aquo-f9d38.appspot.com',
    androidClientId: '776135688708-17sqpto0psao5nq3i95apmp1h18vt5bt.apps.googleusercontent.com',
    iosClientId: '776135688708-ns3t0ap1ucuh7ejj5uqvdj4dhmdbi8an.apps.googleusercontent.com',
    iosBundleId: 'com.example.aquo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6ccW7PgPQ7tMALtvS0aJAQmDmMm74gS0',
    appId: '1:776135688708:ios:92e259dfe3a80c0a866b51',
    messagingSenderId: '776135688708',
    projectId: 'aquo-f9d38',
    databaseURL: 'https://aquo-f9d38-default-rtdb.firebaseio.com',
    storageBucket: 'aquo-f9d38.appspot.com',
    androidClientId: '776135688708-17sqpto0psao5nq3i95apmp1h18vt5bt.apps.googleusercontent.com',
    iosClientId: '776135688708-g6ag0asredp0nodi5lvr9phr8bm7nals.apps.googleusercontent.com',
    iosBundleId: 'com.example.aquo.RunnerTests',
  );
}