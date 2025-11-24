import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'O que é o Estudazz'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: Adicionar a logo do Estudazz
            // Image.asset('assets/images/logo.png'),
            const SizedBox(height: 24),
            Text(
              'Estudazz',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'O Estudazz é uma plataforma de estudos que tem como objetivo ajudar os estudantes a se organizarem melhor e a alcançarem seus objetivos. '
              'A ideia surgiu a partir da necessidade de um grupo de estudantes que sentiam falta de uma ferramenta que os auxiliasse a montar um cronograma de estudos, '
              'a acompanhar o seu desempenho e a encontrar materiais de estudo de qualidade. '
              'Com o Estudazz, você pode criar um plano de estudos personalizado, registrar o seu progresso, acessar um banco de questões e muito mais.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
