import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class BaseGeminiApi {
  Future<String?> getResponseFromGemini({required String prompt});
}

class GeminiAiRepo extends BaseGeminiApi {
  @override
  Future<String?> getResponseFromGemini({required String prompt}) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env['GEMINIAPIKEY'].toString(),
    );
    log('Loading');

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    log(response.text.toString(), name: 'Gemini response');
    return response.text;
  }
}
