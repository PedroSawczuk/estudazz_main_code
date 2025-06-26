import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:flutter/material.dart';

class StatsPerformanceCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String titleStats;
  final String value;
  final bool showProgressBar;
  final double progressValue;

  const StatsPerformanceCard({
    super.key,
    required this.icon,
    required this.color,
    required this.titleStats,
    required this.value,
    this.showProgressBar = false,
    this.progressValue = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, size: 30, color: color),
                  ConstSizedBox.w16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleStats,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ConstSizedBox.h8,
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 18,
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showProgressBar)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator(
                    value: progressValue.clamp(0.0, 1.0),
                    backgroundColor: ConstColors.grey300Color,
                    color: color,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
