import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

class UserDataCard extends StatelessWidget {
  final String label;
  final String value;

  const UserDataCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: ConstColors.grey400Color)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
