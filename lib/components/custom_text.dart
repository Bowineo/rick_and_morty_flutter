import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final bool underline;

  const CustomText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    this.underline = false,
  }) : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: 2,
      style: TextStyle(
        fontFamily: 'Creepster',
        fontSize: widget.fontSize,
        color: widget.color,
        decoration: widget.underline ? TextDecoration.underline : null,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
