import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titleAppBar;
  final bool showPersonIcon;

  CustomAppBar(
      {Key? key, required this.titleAppBar, this.showPersonIcon = false})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          titleAppBar,
        ),
      ),
      actions: showPersonIcon
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                  ),
                  onPressed: () {
                  },
                ),
              ),
            ]
          : [],
    );
  }
}