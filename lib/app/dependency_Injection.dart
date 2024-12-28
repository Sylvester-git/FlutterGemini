// ignore_for_file: file_names

import 'package:get_it/get_it.dart';

import '../cubits/gemini_cubit/gemini_cubit_cubit.dart';
import '../network/apis/gemini_api.dart';
import '../network/repo/geminiRepo.dart';

final instance = GetIt.instance;

Future<void> initDependencyInjector() async {
  //!APIs
  instance.registerLazySingleton<BaseGeminiApi>(() => GeminiAiRepo());

  //! Cubits
  instance.registerFactory<GeminiCubitCubit>(() => GeminiCubitCubit(baseGeminiRepo: instance()));

  //!Repository
  instance.registerLazySingleton<BaseGeminiRepo>(() => GeminiRepo(instance()));
}
