import 'package:flutter/material.dart';
import 'package:flutter_gemini_app/app/dependency_Injection.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AppInit {
  static Future<void> initSetUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await initDependencyInjector();
  }
}
