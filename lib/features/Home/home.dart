import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../app/dependency_Injection.dart';
import '../../network/repo/geminiRepo.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () {
              instance<BaseGeminiRepo>()
                  .generateFromGemini(prompt: 'How do fishes swim ?');
            },
            child: Text(
              dotenv.env['GEMINIAPIKEY'].toString(),
            ),
          ),
        ),
      ),
    );
  }
}
