import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class UserInputMessage extends StatelessWidget {
  final String text;

  const UserInputMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ConstColors.orangeColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: MarkdownBody(
          data: text,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: TextStyle(color: ConstColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
