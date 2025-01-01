import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/gemini_cubit/gemini_cubit_cubit.dart';
import '../../cubits/scroll_controller/scroll_controller_cubit.dart';
import '../../utils/typewriter_text.dart';
import '../result_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final scrollcontrollercubit = context.watch<ScrollControllerCubit>();

    void moveToBottom() {
      log(scrollcontrollercubit.state.scrollController.hasClients.toString());
      if (scrollcontrollercubit.state.scrollController.hasClients) {
        scrollcontrollercubit.state.scrollController.animateTo(
          scrollcontrollercubit.state.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceIn,
        );
      }
    }

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
                    return const Center(
                      child: TypeWriterTextWidget(
                        text: 'How can I help you today',
                        speed: Duration(milliseconds: 10),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
                  if (geministate.result != null ||
                      geministate.result!.isNotEmpty) {
                    return SingleChildScrollView(
                      controller: scrollcontrollercubit.state.scrollController,
                      child: ResultPage(
                        question: geministate.question,
                        resultOutput: geministate.result?.toString() ?? "",
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
                        controller: textController,
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
                                  textController.clear();
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
