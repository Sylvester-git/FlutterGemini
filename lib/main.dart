import 'package:flutter/material.dart';
import 'package:flutter_gemini_app/app/app_init.dart';

import 'features/Home/home.dart';

Future<void> main() async {
  try {
    await AppInit.initSetUp();
    runApp(const RootApp());
  } catch (e) {
    runApp(const RootApp());
  }
}


