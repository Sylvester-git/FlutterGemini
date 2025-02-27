import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini_app/app/app_init.dart';
import 'package:flutter_gemini_app/bloc_observer.dart';


import 'app/root_app.dart';

void main() async {
  await AppInit.initSetUp();
  Bloc.observer = MyBlocObserver();
  runApp(
    kIsWeb
        ? DevicePreview(
            backgroundColor: Colors.white,
            // Enable preview by default for web demo
            enabled: true,
            // Start with Galaxy A50 as it's a common Android device
            defaultDevice: Devices.ios.iPhone13ProMax,
            // Show toolbar to let users test different devices
            isToolbarVisible: true,
            // Keep English only to avoid confusion in demos
            availableLocales: const [Locale('en', 'US')],
            tools: const [
              // Device selection controls
              DeviceSection(
                model: true, // Option to change device model to fit your needs
                orientation: false, // Lock to portrait for consistent demo
                frameVisibility: false, // Hide frame options
                virtualKeyboard: false, // Hide keyboard
              ),
            ],
            devices: [
              ...Devices.all,
            ],
            builder: (context) {
              return const RootApp();
            })
        : const RootApp(),
  );
}
