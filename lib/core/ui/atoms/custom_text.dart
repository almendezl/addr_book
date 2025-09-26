import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.isBold = false,
    this.color = Colors.black,
    this.fontSize = 14,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
