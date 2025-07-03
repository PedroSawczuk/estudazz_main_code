import 'package:estudazz_main_code/components/cards/performance/highlightPerformanceCard.dart';
import 'package:estudazz_main_code/components/cards/performance/statsPerformanceCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  final TasksRepository _tasksRepository = TasksRepository();
  PerformancePage({super.key});

  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Desempenho'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstSizedBox.h20,
            HighlightPerformanceCard(
              textCard: 'Bom trabalho! Você está indo bem!',
              textCardColor: ConstColors.orangeColor,
              icon: Icons.star,
              iconColor: ConstColors.orangeColor,
            ),
            ConstSizedBox.h20,
            StatsPerformanceCard(
              icon: Icons.bar_chart,
              color: ConstColors.blueColor,
              titleStats: 'Desempenho Acadêmico',
              value: '20%',
              showProgressBar: true,
              progressValue: 20 / 100,
            ),
            ConstSizedBox.h20,
            StreamBuilder<Map<String, int>>(
              stream: _tasksRepository.getTasksStats(uid!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar dados: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Nenhuma tarefa encontrada');
                }

                final data = snapshot.data!;
                final total = data['total'] ?? 0;
                final completed = data['completed'] ?? 0;
                final progress = total > 0 ? completed / total : 0.0;

                return StatsPerformanceCard(
                  icon: Icons.task_alt,
                  color: ConstColors.greenColor,
                  titleStats: 'Tarefas Concluídas',
                  value: '$completed/$total',
                  showProgressBar: true,
                  progressValue: progress,
                );
              },
            ),

            ConstSizedBox.h20,
            StatsPerformanceCard(
              icon: Icons.check_circle,
              color: ConstColors.orangeColor,
              titleStats: 'Taxa de Conclusão de Tarefas',
              value: '${84.toStringAsFixed(2)}%',
              showProgressBar: false,
            ),
            ConstSizedBox.h20,
            StatsPerformanceCard(
              icon: Icons.groups,
              color: ConstColors.purpleColor,
              titleStats: 'Grupos de Estudo',
              value: '42/50',
              showProgressBar: false,
            ),
            ConstSizedBox.h20,
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
