import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_app/utils/assets.dart';

import '../../cubits/gemini_cubit/gemini_cubit_cubit.dart';
import '../../utils/typewriter_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            //! Answer Page
            Expanded(
                child: Container(
              color: Colors.transparent,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: BlocBuilder<GeminiCubitCubit, GeminiState>(
                builder: (context, geministate) {
                  if (geministate.isSearching) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1,
                      ),
                    );
                  }
                  if (geministate.result == null ||
                      geministate.result!.isEmpty) {
                    return Center(
                      child: TypeWriterTextWidget(
                        text: 'How can i help you today',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        soundEffect: AppAssets.typewrittersound,
                      ),
                    );
                  }
                  if (geministate.result != null ||
                      geministate.result!.isNotEmpty) {
                    return SingleChildScrollView(
                      child: TypeWriterTextWidget(
                        soundEffect: AppAssets.typewrittersound,
                        text: geministate.result?.toString() ?? "",
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            //! Answer Page
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 48,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          context
                              .read<GeminiCubitCubit>()
                              .changeSearchValue(text: value);
                        },
                        controller: _textController,
                        cursorColor: Colors.white,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        decoration: InputDecoration(
                          border: Theme.of(context).inputDecorationTheme.border,
                          enabledBorder: Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder,
                          focusedBorder: Theme.of(context)
                              .inputDecorationTheme
                              .focusedBorder,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<GeminiCubitCubit, GeminiState>(
                      builder: (context, geministate) {
                        return InkWell(
                          onTap: geministate.question.isEmpty
                              ? null
                              : () {
                                  context.read<GeminiCubitCubit>().search();
                                  _textController.clear();
                                },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: geministate.question.isEmpty
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.white,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_upward_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
