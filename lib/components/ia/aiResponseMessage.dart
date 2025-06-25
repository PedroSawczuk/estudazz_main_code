import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AIResponseMessage extends StatelessWidget {
  final String text;

  const AIResponseMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ConstColors.grey300Color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: MarkdownBody(
          data: text,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: TextStyle(
              color: ConstColors.black87Color,
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
            a: TextStyle(
              color: ConstColors.blueColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
            code: TextStyle(
              color: ConstColors.whiteColor,
              backgroundColor: ConstColors.grey900Color,
              fontFamily: 'SourceCodePro',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
