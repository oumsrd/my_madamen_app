import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:819124698394:android:421bbca1e41e29acc800a3',
        apiKey: ' AIzaSyDr804yfts2sSsRb7qPIIXUDrScrclbrR8',
        projectId: 'my-e-commercial-app-5ed79',
        messagingSenderId: '819124698394		',
        iosBundleId: '"com.example.test_flutter/cliente',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:819124698394:android:421bbca1e41e29acc800a3',
        apiKey: 'AIzaSyDr804yfts2sSsRb7qPIIXUDrScrclbrR8',
        projectId: 'my-e-commercial-app-5ed79',
        messagingSenderId: '819124698394	',
      );
    }
  }
}
