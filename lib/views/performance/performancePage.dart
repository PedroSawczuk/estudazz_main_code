import 'package:estudazz_main_code/components/cards/performance/highlightPerformanceCard.dart';
import 'package:estudazz_main_code/components/cards/performance/statsPerformanceCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Desempenho'),
      body: Column(
        children: [
          SizedBox(height: 20),
          HighlightPerformanceCard(
            textCard: 'Bom trabalho! Você está indo bem!',
            textCardColor: ConstColors.orangeColor,
            icon: Icons.star,
            iconColor: ConstColors.orangeColor,
          ),
          SizedBox(height: 20),
          StatsPerformanceCard(
            icon: Icons.bar_chart,
            color: Colors.blue,
            titleStats: 'Desempenho Acadêmico',
            value: '20%',
            showProgressBar: true,
            progressValue: 20 / 100,
          ),
        ],
      ),
    );
  }
}
