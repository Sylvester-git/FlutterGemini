import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini_app/app/dependency_Injection.dart';

class AppInit {
  static Future<void> initSetUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await initDependencyInjector();
  }
}
