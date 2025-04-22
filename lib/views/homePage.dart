import 'package:estudazz_main_code/components/cards/homeCards.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/utils/user/authProfileCheck.dart';
import 'package:estudazz_main_code/utils/user/userAuthCheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/homePageController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _profileController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    checkProfileCompletion(_profileController, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Estudazz', showPersonIcon: true),
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
                onTap:
                    () => AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated:
                          () => Get.toNamed(AppRoutes.allTasksPage),
                    ),
              ),
              ItensCards(
                title: "Calendário",
                description: "Veja seus prazos e compromissos.",
                icon: Icons.calendar_today,
                color: Colors.orange,
                onTap:
                    () => AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated:
                          () => Get.toNamed(AppRoutes.calendarPage),
                    ),
              ),
              ItensCards(
                title: "Grupos de Estudo",
                description: "Colabore com colegas.",
                icon: Icons.groups,
                color: Colors.purple,
                onTap:
                    () => AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated:
                          () => Get.toNamed(AppRoutes.studyGroupPage),
                    ),
              ),
              ItensCards(
                title: "Desempenho",
                description: "Acompanhe seu progresso acadêmico.",
                icon: Icons.bar_chart,
                color: Colors.blue,
                onTap:
                    () => AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated:
                          () => Get.toNamed(AppRoutes.performancePage),
                    ),
              ),
              ItensCards(
                title: "Inteligência Artificial",
                description: "Receba recomendações personalizadas com IA.",
                icon: Icons.lightbulb,
                color: Colors.indigo,
                onTap:
                    () => AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated: () => Get.toNamed(AppRoutes.iaPage),
                    ),
              ),
              ItensCards(
                title: "Configurações",
                description: "Personalize a sua experiência.",
                icon: Icons.settings,
                color: Color(0xFFB90F0F),
                onTap:
                    () => AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated:
                          () => Get.toNamed(AppRoutes.settingsPage),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
