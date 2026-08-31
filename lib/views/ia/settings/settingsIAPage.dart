import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/dialog/ia/iaResetChat.dart';
import 'package:estudazz_main_code/components/dialog/ia/iaResetDataDialog.dart';
import 'package:estudazz_main_code/components/dialog/ia/iaTrainingNewDataDialog.dart';
import 'package:flutter/material.dart';

class SettingsAIPage extends StatefulWidget {
  const SettingsAIPage({super.key});

  @override
  State<SettingsAIPage> createState() => _SettingsAIPageState();
}

class _SettingsAIPageState extends State<SettingsAIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Configurações da IA'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Treinar IA com Novos Dados'),
              subtitle: const Text(
                'Adicione informações para melhorar as respostas.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const IATrainingNewDataDialog(),
                );
              },
            ),
            ListTile(
              title: const Text('Redefinir Configurações de IA'),
              subtitle: const Text('Restaura para os padrões originais.'),
              trailing: const Icon(Icons.restore),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const IAResetConfirmationDialog(),
                );
              },
            ),
            ListTile(
              title: const Text('Limpar conversa com a IA'),
              subtitle: const Text('Remover todas as mensagens da conversa.'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const IAResetChat(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
