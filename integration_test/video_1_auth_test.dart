import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:estudazz_main_code/main.dart' as app;

/// Toca no botão silenciosamente, simulando a callback da interface
/// sem disparar a mira visual vermelha do framework de testes.
Future<void> stealthTap(WidgetTester tester, Finder finder) async {
  final widget = tester.firstWidget(finder);
  if (widget is ElevatedButton) {
    widget.onPressed?.call();
  } else if (widget is TextButton) {
    widget.onPressed?.call();
  } else if (widget is IconButton) {
    widget.onPressed?.call();
  } else if (widget is GestureDetector) {
    widget.onTap?.call();
  } else if (widget is InkWell) {
    widget.onTap?.call();
  } else {
    // Fallback: vai dar a mira vermelha mas pelo menos clica
    await tester.tap(finder); 
  }
}

/// Digita o texto no campo um caractere por vez com um atraso,
/// simulando um humano digitando, em vez de injetar tudo de uma vez.
Future<void> typeTextLikeHuman(WidgetTester tester, Finder finder, String text) async {
  // Dá um tap normal apenas para focar o campo
  await tester.tap(finder);
  await tester.pump(const Duration(milliseconds: 300));
  
  // Oculta o teclado gigantesco que sobe, se possível (embora no Android às vezes ele teima em ficar)
  await tester.testTextInput.receiveAction(TextInputAction.done);
  
  // Digitação lenta caractere por caractere
  for (int i = 1; i <= text.length; i++) {
    await tester.enterText(finder, text.substring(0, i));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Video 1: Autenticação e Preenchimento de Perfil', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final createAccountBtn = find.text('Crie aqui');
    await stealthTap(tester, find.ancestor(of: createAccountBtn, matching: find.byType(TextButton)).first);
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final signUpEmailInput = find.widgetWithText(TextFormField, 'Email');
    final signUpPasswordInput = find.widgetWithText(TextFormField, 'Senha');
    
    await typeTextLikeHuman(tester, signUpEmailInput, 'usuario@gmail.com');
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    
    await typeTextLikeHuman(tester, signUpPasswordInput, 'Senha112233@');
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    final btnCreate = find.widgetWithText(ElevatedButton, 'Criar Conta');
    await stealthTap(tester, btnCreate);
    
    await Future.delayed(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    final signInEmailInput = find.widgetWithText(TextFormField, 'Email');
    final signInPasswordInput = find.widgetWithText(TextFormField, 'Senha');
    
    await typeTextLikeHuman(tester, signInEmailInput, 'usuario@gmail.com');
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await typeTextLikeHuman(tester, signInPasswordInput, 'Senha112233@');
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    final btnSignIn = find.widgetWithText(ElevatedButton, 'Entrar');
    await stealthTap(tester, btnSignIn);
    
    await Future.delayed(const Duration(seconds: 6));
    await tester.pumpAndSettle();

    final btnSettings = find.ancestor(of: find.text('Configurações'), matching: find.byType(GestureDetector));
    if (btnSettings.evaluate().isNotEmpty) {
      await stealthTap(tester, btnSettings.first);
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      
      final btnMyData = find.ancestor(of: find.text('Meus Dados'), matching: find.byType(GestureDetector)); 
      if (btnMyData.evaluate().isNotEmpty) {
        await stealthTap(tester, btnMyData.first);
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
        
        final btnEdit = find.byIcon(Icons.edit);
        if (btnEdit.evaluate().isNotEmpty) {
          await stealthTap(tester, btnEdit);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
        }
      }
    } else {
      final btnComplete = find.widgetWithText(ElevatedButton, 'Complete seu perfil');
      if (btnComplete.evaluate().isNotEmpty) {
        await stealthTap(tester, btnComplete);
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      }
    }

    final nameInput = find.widgetWithText(TextFormField, 'Nome');
    if (nameInput.evaluate().isNotEmpty) {
      final usernameInput = find.widgetWithText(TextFormField, 'Username');
      final birthInput = find.widgetWithText(TextFormField, 'Data de Nascimento');
      final institutionInput = find.widgetWithText(TextFormField, 'Instituição');
      final courseInput = find.widgetWithText(TextFormField, 'Curso');
      final graduationInput = find.widgetWithText(TextFormField, 'Conclusão (MM/AAAA)');

      await typeTextLikeHuman(tester, nameInput, 'Usuário de Teste');
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      
      await typeTextLikeHuman(tester, usernameInput, 'usuario');
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      
      await typeTextLikeHuman(tester, birthInput, '01012000');
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await typeTextLikeHuman(tester, institutionInput, 'IFRO');
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      await typeTextLikeHuman(tester, courseInput, 'ADS');
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      
      await typeTextLikeHuman(tester, graduationInput, '122028');
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      final btnSave = find.widgetWithText(ElevatedButton, 'Salvar Alterações');
      await stealthTap(tester, btnSave);
      
      await Future.delayed(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    }
  });
}
