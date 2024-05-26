// ignore_for_file: file_names

import 'package:google_generative_ai/google_generative_ai.dart';

import '../apis/gemini_api.dart';

abstract class BaseGeminiRepo {
  Future<String?> generateFromGemini({required String prompt});
}

class GeminiRepo extends BaseGeminiRepo {
  final BaseGeminiApi _baseGeminiApi;
   GeminiRepo(this._baseGeminiApi);
  @override
  Future<String?> generateFromGemini({required String prompt}) async {
    try {
      final response =
          await _baseGeminiApi.getResponseFromGemini(prompt: prompt);
      return response;
    } on GenerativeAIException catch (_) {
      rethrow;
    }
  }
}
