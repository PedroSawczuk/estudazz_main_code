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
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[400])),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
