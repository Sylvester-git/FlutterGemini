// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/scroll_controller/scroll_controller_cubit.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TypeWriterTextWidget extends StatefulWidget {
  const TypeWriterTextWidget({
    super.key,
    this.speed = const Duration(microseconds: 10),
    required this.text,
    required this.textStyle,
  });

  final String text;
  final TextStyle textStyle;
  final Duration speed;

  @override
  State<TypeWriterTextWidget> createState() => _TypeWriterTextWidgetState();
}

class _TypeWriterTextWidgetState extends State<TypeWriterTextWidget> {
  String _displayedText = '';
  int _currentIndex = 0;
  late Timer _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void moveToBottom() {
    final controller = BlocProvider.of<ScrollControllerCubit>(context).state;
    log('HELLO');
    if (controller.scrollController.hasClients) {
      log('HAS CLIENT');
      controller.scrollController
          .jumpTo(controller.scrollController.position.maxScrollExtent);
      log(controller.scrollController.position.maxScrollExtent.toString());
    }
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) async {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        });
        moveToBottom();
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: _displayedText,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        h1: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        h2: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        h3: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        p: const TextStyle(fontSize: 16, color: Colors.white),
        tableBorder: TableBorder.all(
          color: Colors.white,
          style: BorderStyle.solid,
        ),
        tableHead: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        tableCellsPadding: const EdgeInsets.all(10),
        tableBody: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        blockquote: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
        blockquoteDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        code: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(.08),
        ),
        
        listBullet: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        h4: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
    //  Text(
    //   _displayedText,
    //   softWrap: true,
    //   style: widget.textStyle,
    // );
  }
}
