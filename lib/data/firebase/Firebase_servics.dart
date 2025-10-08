import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {

    switch (defaultTargetPlatform) {

      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM9bQlPMoBXZNh1ubYd8S8kjmwQBeBNEs',
    appId: '1:515189934105:android:409141286fab1a7c280288',
    messagingSenderId: '515189934105',
    projectId: 'placementapp-2d53e',
    storageBucket: 'placementapp-2d53e.firebasestorage.app',
  );
}