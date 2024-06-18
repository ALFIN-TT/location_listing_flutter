import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
   CommonText(
      {Key? key,
      required this.text,
      this.textStyle,
      required this.minFontSize,
      required this.maxFontSize,
      required this.onTap})
      : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final double minFontSize;
  final double maxFontSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: AutoSizeText(
          text,
          minFontSize: minFontSize,
          maxFontSize: maxFontSize,
          style: textStyle,
        ));
  }
}
