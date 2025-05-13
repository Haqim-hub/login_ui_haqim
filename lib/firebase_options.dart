// File generated manually based on google-services.json.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTcBDYim575cv5LcaAPoO0Bi1BLGW-RGc',
    appId: '1:73092897315:android:452998128fe1454905ef96',
    messagingSenderId: '73092897315',
    projectId: 'mobile-c6d38',
    storageBucket: 'mobile-c6d38.appspot.com', // Corrected from .app to .com
    databaseURL: 'https://mobile-c6d38-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
}
