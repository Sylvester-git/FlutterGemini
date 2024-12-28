import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class TypeWriterTextWidget extends StatefulWidget {
  const TypeWriterTextWidget({
    super.key,
    this.speed = const Duration(milliseconds: 25),
    required this.text,
    required this.textStyle,
    required this.soundEffect,
  });

  final String text;
  final TextStyle textStyle;
  final Duration speed;
  final String soundEffect;

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

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) async {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        });
        //! Play sound effect
        await _audioPlayer.play(AssetSource(widget.soundEffect));
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
