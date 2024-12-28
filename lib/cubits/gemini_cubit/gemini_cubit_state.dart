// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'gemini_cubit_cubit.dart';

class GeminiState extends Equatable {
  final bool isSearching;
  final String? result;
  final String question;
  final bool hasError;
  final String error;

  factory GeminiState.initial() {
    return const GeminiState(
      isSearching: false,
      result: '',
      question: '',
      hasError: false,
      error: '',
    );
  }

  const GeminiState(
      {required this.isSearching,
      required this.result,
      required this.question,
      required this.hasError,
      required this.error});

  GeminiState copyWith({
    bool? isSearching,
    String? result,
    String? question,
    bool? hasError,
    String? error,
  }) {
    return GeminiState(
      isSearching: isSearching ?? this.isSearching,
      result: result ?? this.result,
      question: question ?? this.question,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isSearching,
        result,
        question,
        hasError,
        error,
      ];
}
