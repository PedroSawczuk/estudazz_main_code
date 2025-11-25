import 'package:estudazz_main_code/components/cards/home/homeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Um mock simples para a função de callback
class TapCounter {
  int count = 0;
  void call() {
    count++;
  }
}

void main() {
  // Helper para renderizar o widget dentro do MaterialApp
  Future<void> pumpItensCards(
    WidgetTester tester, {
    required VoidCallback onTap,
  }) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ItensCards(
          title: 'Título do Card',
          description: 'Descrição do Card',
          icon: Icons.home,
          color: Colors.blue,
          onTap: onTap,
        ),
      ),
    ));
  }

  group('ItensCards Widget Test', () {
    testWidgets('deve renderizar o título, descrição e ícones corretamente', (WidgetTester tester) async {
      // ARRANGE: Prepara o widget
      await pumpItensCards(tester, onTap: () {});

      // ASSERT: Verifica se os elementos estão na tela
      expect(find.text('Título do Card'), findsOneWidget);
      expect(find.text('Descrição do Card'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      // O card também tem um ícone de chevron
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('deve chamar a função onTap ao ser tocado', (WidgetTester tester) async {
      // ARRANGE: Prepara um contador para verificar o toque
      final tapCounter = TapCounter();
      await pumpItensCards(tester, onTap: tapCounter.call);

      // ACT: Simula o toque no widget
      await tester.tap(find.byType(ItensCards));
      await tester.pump(); // Avança um frame

      // ASSERT: Verifica se a função de callback foi chamada uma vez
      expect(tapCounter.count, 1);
    });

    testWidgets('não deve chamar a função onTap sem um toque', (WidgetTester tester) async {
      // ARRANGE
      final tapCounter = TapCounter();
      await pumpItensCards(tester, onTap: tapCounter.call);

      // ACT: Não faz nada

      // ASSERT
      expect(tapCounter.count, 0);
    });
  });
}
