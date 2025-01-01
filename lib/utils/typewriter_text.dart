import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/scroll_controller/scroll_controller_cubit.dart';

class TypeWriterTextWidget extends StatefulWidget {
  const TypeWriterTextWidget({
    super.key,
    this.speed = const Duration(milliseconds: 5),
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
    return Text(
      _displayedText,
      softWrap: true,
      style: widget.textStyle,
    );
  }
}
