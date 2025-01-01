import 'package:flutter/material.dart';

import '../utils/typewriter_text.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(
      {super.key, required this.resultOutput, required this.question});

  final String resultOutput;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Question
        Align(
          alignment: Alignment.topRight,
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.sizeOf(context).width / 10, bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: TypeWriterTextWidget(
                  text: question,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        //! Answer
        Align(
          alignment: Alignment.topLeft,
          child: IntrinsicHeight(
            child: Container(
              margin:
                  EdgeInsets.only(right: MediaQuery.sizeOf(context).width / 10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: TypeWriterTextWidget(
                text: resultOutput,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /**
   * 
   */
}
