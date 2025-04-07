import 'package:estudazz_main_code/components/cards/homeCards.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

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
                onTap: () {},
              ),
              ItensCards(
                title: "Calendário",
                description: "Veja seus prazos e compromissos.",
                icon: Icons.calendar_today,
                color: Colors.orange,
                onTap: () {},
              ),
              ItensCards(
                title: "Grupos de Estudo",
                description: "Colabore com colegas.",
                icon: Icons.groups,
                color: Colors.purple,
                onTap: () {},
              ),
              ItensCards(
                title: "Desempenho",
                description: "Acompanhe seu progresso acadêmico.",
                icon: Icons.bar_chart,
                color: Colors.blue,
                onTap: () {},
              ),
              ItensCards(
                title: "Inteligência Artificial",
                description: "Receba recomendações personalizadas com IA.",
                icon: Icons.lightbulb,
                color: Colors.indigo,
                onTap: () {},
              ),
              ItensCards(
                title: "Configurações",
                description: "Personalize a sua experiência.",
                icon: Icons.settings,
                color: Color(0xFFB90F0F),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
