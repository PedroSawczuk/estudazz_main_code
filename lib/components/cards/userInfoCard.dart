import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String label;
  final String value;

  UserInfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: ConstColors.grey400Color)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
