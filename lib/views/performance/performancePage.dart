import 'package:estudazz_main_code/components/cards/performance/highlightPerformanceCard.dart';
import 'package:estudazz_main_code/components/cards/performance/statsPerformanceCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/services/db/calendar/eventsRepository.dart';
import 'package:estudazz_main_code/services/db/studyRoom/studyRoomDb.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  final TasksRepository _tasksRepository = TasksRepository();
  final EventsRepository _eventsRepository = EventsRepository();
  final StudyRoomDB _studyRoomDB = StudyRoomDB();

  PerformancePage({super.key});

  final uid = FirebaseAuth.instance.currentUser?.uid;

  Map<String, dynamic> _getPerformanceFeedback(double completionRate) {
    if (completionRate == 0) {
      return {
        'text': 'Você ainda não começou, vamos lá!',
        'color': ConstColors.greyColor,
        'icon': Icons.hourglass_empty,
      };
    } else if (completionRate < 40) {
      return {
        'text': 'Você pode melhorar, foco nas suas tarefas!',
        'color': ConstColors.redColor,
        'icon': Icons.trending_down,
      };
    } else if (completionRate < 70) {
      return {
        'text': 'Você está indo bem, continue assim!',
        'color': ConstColors.orangeColor,
        'icon': Icons.trending_flat,
      };
    } else {
      return {
        'text': 'Excelente! Continue nesse ritmo!',
        'color': ConstColors.greenColor,
        'icon': Icons.trending_up,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Desempenho'),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                final completionRate =
                    total > 0 ? (completed / total) * 100 : 0.0;

                final feedback = _getPerformanceFeedback(completionRate);

                return Column(
                  children: [
                    HighlightPerformanceCard(
                      textCard: feedback['text'],
                      textCardColor: feedback['color'],
                      icon: feedback['icon'],
                      iconColor: feedback['color'],
                    ),
                    ConstSizedBox.h20,
                    StatsPerformanceCard(
                      icon: Icons.task_alt,
                      color: ConstColors.greenColor,
                      titleStats: 'Tarefas Concluídas',
                      value: '$completed/$total',
                      showProgressBar: true,
                      progressValue: progress,
                    ),
                    ConstSizedBox.h20,
                    StatsPerformanceCard(
                      icon: Icons.check_circle,
                      color: ConstColors.orangeColor,
                      titleStats: 'Taxa de Conclusão de Tarefas',
                      value: '${completionRate.toStringAsFixed(2)}%',
                      showProgressBar: false,
                    ),
                  ],
                );
              },
            ),
            ConstSizedBox.h20,
            StreamBuilder<Map<String, int>>(
              stream: _eventsRepository.getEventsStats(uid!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar dados: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Nenhum evento encontrado');
                }

                final data = snapshot.data!;
                final total = data['total'] ?? 0;

                return StatsPerformanceCard(
                  icon: Icons.calendar_today,
                  color: ConstColors.lightBlueColor,
                  titleStats: 'Eventos Criados',
                  value: '$total',
                  showProgressBar: false,
                );
              },
            ),
            ConstSizedBox.h20,
            StreamBuilder<Map<String, int>>(
              stream: _studyRoomDB.getParticipatedStudyRoomsStats(uid!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar dados: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('Nenhuma sala de estudos que participa');
                }

                final data = snapshot.data!;
                final total = data['total'] ?? 0;

                return StatsPerformanceCard(
                  icon: Icons.group_work,
                  color: ConstColors.purpleColor,
                  titleStats: 'Salas de Estudo',
                  value: '$total',
                  showProgressBar: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
