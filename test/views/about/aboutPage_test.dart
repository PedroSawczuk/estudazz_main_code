import 'package:estudazz_main_code/views/about/aboutPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Helper para renderizar a tela dentro do MaterialApp
  Future<void> pumpAboutPage(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AboutPage(),
    ));
  }

  group('AboutPage Widget Test', () {
    testWidgets('deve renderizar todos os textos estáticos corretamente', (WidgetTester tester) async {
      // ARRANGE
      await pumpAboutPage(tester);

      // ASSERT
      // Verifica o título na AppBar
      expect(find.text('O que é o Estudazz'), findsOneWidget);

      // Verifica o cabeçalho principal
      expect(find.text('Estudazz'), findsOneWidget);

      // Verifica parte do texto de descrição (não precisa ser o texto inteiro)
      expect(find.textContaining('plataforma de estudos que tem como objetivo'), findsOneWidget);

      // Verifica a versão
      expect(find.text('Versão 1.0.0'), findsOneWidget);
    });

    testWidgets('deve ser rolável', (WidgetTester tester) async {
      // ARRANGE
      await pumpAboutPage(tester);

      // ACT & ASSERT
      // Verifica se o corpo da tela é rolável
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
