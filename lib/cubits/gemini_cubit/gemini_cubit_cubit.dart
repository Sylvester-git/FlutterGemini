import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../network/repo/geminiRepo.dart';

part 'gemini_cubit_state.dart';

class GeminiCubitCubit extends Cubit<GeminiState> {
  final BaseGeminiRepo _baseGeminiRepo;
  GeminiCubitCubit({required BaseGeminiRepo baseGeminiRepo})
      : _baseGeminiRepo = baseGeminiRepo,
        super(GeminiState.initial());

  void changeSearchValue({required String text}) {
    emit(state.copyWith(question: text));
  }

  void resetGeminiCubit() {
    emit(GeminiState.initial());
  }

  Future<void> search() async {
    if (state.isSearching) return;
    emit(state.copyWith(isSearching: true));
    final response =
        await _baseGeminiRepo.generateFromGemini(prompt: state.question);
    response.fold((l) {
      emit(state.copyWith(isSearching: false, error: l, hasError: true));
      emit(state.copyWith(hasError: false));
    }, (r) {
      emit(state.copyWith(
        isSearching: false,
        result: r,
      ));
    });
  }
}
