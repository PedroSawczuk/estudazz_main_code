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
      body: SingleChildScrollView(
        child: Column(
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
              color: ConstColors.blueColor,
              titleStats: 'Desempenho Acadêmico',
              value: '20%',
              showProgressBar: true,
              progressValue: 20 / 100,
            ),
            StatsPerformanceCard(
              icon: Icons.task_alt,
              color: ConstColors.greenColor,
              titleStats: 'Tarefas Concluídas',
              value: '42/50',
              showProgressBar: true,
              progressValue: 84 / 100,
            ),
            StatsPerformanceCard(
              icon: Icons.groups,
              color: ConstColors.purpleColor,
              titleStats: 'Grupos de Estudo',
              value: '42/50',
              showProgressBar: false,
            ),
            StatsPerformanceCard(
              icon: Icons.check_circle,
              color: ConstColors.orangeColor,
              titleStats: 'Taxa de Conclusão de Tarefas',
              value: '${84.toStringAsFixed(2)}%',
              showProgressBar: false,
            ),
            StatsPerformanceCard(
              icon: Icons.check_circle,
              color: ConstColors.lightBlueColor,
              titleStats: 'Eventos Criados',
              value: '5',
              showProgressBar: false,
            ),
          ],
        ),
      ),
    );
  }
}
