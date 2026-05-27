import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/initial_binding.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDo_Q8TWbu2PNHSv_WExn9BQuGk510SKW4",
        authDomain: "careconnect-pk.firebaseapp.com",
        projectId: "careconnect-pk",
        storageBucket: "careconnect-pk.firebasestorage.app",
        messagingSenderId: "560973486964",
        appId: "1:560973486964:web:c04eb6a0362be55a9eea21",
        measurementId: "G-GE2HDWSQBS",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const CareConnectApp());
}

class CareConnectApp extends StatelessWidget {
  const CareConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CareConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialBinding: AppBindings(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
