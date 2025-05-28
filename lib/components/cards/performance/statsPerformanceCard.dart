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
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, size: 30, color: color),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleStats,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator(
                  value: progressValue.clamp(0.0, 1.0),
                  backgroundColor: Color(0xFFE0E0E0),
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
