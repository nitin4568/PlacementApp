import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:placement/resource/dependency_inject/dependency_injection.dart';
import 'package:placement/resource/routes/app_routes.dart';
import 'package:placement/resource/routes/routs.dart';
import 'data/firebase/Firebase_servics.dart';

// Background FCM handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await dotenv.load(fileName: ".env");


  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  await GetStorage.init();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Placement App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          initialRoute: AppRouteNames.login,
          getPages: AppRoutes.appRoutes(),
        );
      },
    );
  }
}
