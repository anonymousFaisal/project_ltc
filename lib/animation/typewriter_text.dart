import 'dart:async';
import 'package:flutter/material.dart';

class TypeWriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration? delay;

  TypeWriterText({required this.text, this.style, this.delay});

  @override
  _TypeWriterTextState createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  late String currentText = "";

  @override
  void initState() {
    super.initState();
    // Add delay if provided, otherwise start immediately
    Future.delayed(widget.delay ?? Duration.zero, () {
      _animateText();
    });
  }

  _animateText() async {
    for (int i = 0; i < widget.text.length; i++) {
      await Future.delayed(Duration(milliseconds: 60));
      setState(() {
        currentText = widget.text.substring(0, i + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentText,
      style: widget.style,
    );
  }
}
