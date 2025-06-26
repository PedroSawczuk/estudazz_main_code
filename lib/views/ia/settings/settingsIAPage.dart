import 'package:estudazz_main_code/components/custom/customAppBar.dart';
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
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Ativar Dicas de Produtividade'),
              subtitle: Text('Receba sugestões para melhorar seu estudo.'),
              value: true,
              onChanged: (bool value) {},
            ),
            SwitchListTile(
              title: Text('Habilitar Respostas Personalizadas'),
              subtitle: Text('Ajuste as respostas com base no seu perfil.'),
              value: false,
              onChanged: (bool value) {},
            ),
            ListTile(
              title: Text('Treinar IA com Novos Dados'),
              subtitle: Text(
                'Adicione informações para melhorar as respostas.',
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => IATrainingNewDataDialog(),
                );
              },
            ),
            ListTile(
              title: Text('Redefinir Configurações de IA'),
              subtitle: Text('Restaura para os padrões originais.'),
              trailing: Icon(Icons.restore),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => IAResetConfirmationDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
