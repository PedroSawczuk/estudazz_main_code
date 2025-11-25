import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Helper function to pump the widget within a MaterialApp
  Future<void> pumpAppBar(WidgetTester tester, CustomAppBar appBar) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: appBar,
      ),
    ));
  }

  group('CustomAppBar Widget Test', () {
    testWidgets('deve exibir o título corretamente', (WidgetTester tester) async {
      const String title = 'Meu Título de Teste';
      await pumpAppBar(tester, CustomAppBar(titleAppBar: title));

      expect(find.text(title), findsOneWidget);
    });

    testWidgets('não deve exibir ícones por padrão', (WidgetTester tester) async {
      await pumpAppBar(tester, CustomAppBar(titleAppBar: 'Teste'));

      expect(find.byIcon(Icons.person), findsNothing);
      expect(find.byIcon(Icons.settings), findsNothing);
      expect(find.byIcon(Icons.group), findsNothing);
    });

    testWidgets('deve exibir o ícone de perfil quando showPersonIcon é true', (WidgetTester tester) async {
      await pumpAppBar(tester, CustomAppBar(titleAppBar: 'Teste', showPersonIcon: true));

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('deve exibir o ícone de configurações quando showSettingsIAIcon é true', (WidgetTester tester) async {
      await pumpAppBar(tester, CustomAppBar(titleAppBar: 'Teste', showSettingsIAIcon: true));

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('deve exibir o ícone de membros quando showMembersIcon é true', (WidgetTester tester) async {
      await pumpAppBar(tester, CustomAppBar(titleAppBar: 'Teste', showMembersIcon: true));

      expect(find.byIcon(Icons.group), findsOneWidget);
    });

    testWidgets('deve exibir múltiplos ícones corretamente', (WidgetTester tester) async {
      await pumpAppBar(
        tester,
        CustomAppBar(
          titleAppBar: 'Teste',
          showPersonIcon: true,
          showMembersIcon: true,
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.group), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsNothing);
    });
  });
}
