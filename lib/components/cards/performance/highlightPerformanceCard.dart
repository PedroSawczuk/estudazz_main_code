import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:flutter/material.dart';

class HighlightPerformanceCard extends StatelessWidget {
  final String textCard;
  final Color textCardColor;
  final IconData icon;
  final Color iconColor;

  const HighlightPerformanceCard({
    super.key,
    required this.textCard,
    required this.textCardColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 30),
              ConstSizedBox.h10,
              Text(
                textCard,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textCardColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
