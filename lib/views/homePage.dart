import 'package:estudazz_main_code/components/cards/homeCards.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Estudazz'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ItensCards(
                title: "Minhas Tarefas",
                description: "Gerencie suas tarefas pendentes.",
                icon: Icons.task_alt,
                color: Colors.teal,
                onTap: () {
                  Get.toNamed(AppRoutes.allTasksPage);
                },
              ),
              ItensCards(
                title: "Calendário",
                description: "Veja seus prazos e compromissos.",
                icon: Icons.calendar_today,
                color: Colors.orange,
                onTap: () {
                  Get.toNamed(AppRoutes.calendarPage);
                },
              ),
              ItensCards(
                title: "Grupos de Estudo",
                description: "Colabore com colegas.",
                icon: Icons.groups,
                color: Colors.purple,
                onTap: () {
                  Get.toNamed(AppRoutes.studyGroupPage);
                },
              ),
              ItensCards(
                title: "Desempenho",
                description: "Acompanhe seu progresso acadêmico.",
                icon: Icons.bar_chart,
                color: Colors.blue,
                onTap: () {
                  Get.toNamed(AppRoutes.performancePage);
                },
              ),
              ItensCards(
                title: "Inteligência Artificial",
                description: "Receba recomendações personalizadas com IA.",
                icon: Icons.lightbulb,
                color: Colors.indigo,
                onTap: () {
                  Get.toNamed(AppRoutes.iaPage);
                },
              ),
              ItensCards(
                title: "Configurações",
                description: "Personalize a sua experiência.",
                icon: Icons.settings,
                color: Color(0xFFB90F0F),
                onTap: () {
                  Get.toNamed(AppRoutes.settingsPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
