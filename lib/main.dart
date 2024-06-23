import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tattoo_social_app/config/app_config.dart';
import 'package:tattoo_social_app/config/routes.dart';
import 'package:tattoo_social_app/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: AppConfig.firebaseApiKey,
      appId: AppConfig.firebaseAppId,
      messagingSenderId: AppConfig.firebaseMessagingSenderId,
      projectId: AppConfig.firebaseProjectId,
      storageBucket: AppConfig.firebaseStorageBucket,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
