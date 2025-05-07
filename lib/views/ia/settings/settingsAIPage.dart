import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class SettingsAIPage extends StatelessWidget {
  const SettingsAIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Configurações da IA'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Ativar Dicas de Produtividade'),
              subtitle: const Text(
                'Receba sugestões para melhorar seu estudo.',
              ),
              value: true,
              onChanged: (bool value) {},
            ),
            SwitchListTile(
              title: const Text('Habilitar Respostas Personalizadas'),
              subtitle: const Text(
                'Ajuste as respostas com base no seu perfil.',
              ),
              value: false,
              onChanged: (bool value) {},
            ),
            ListTile(
              title: const Text('Treinar IA com Novos Dados'),
              subtitle: const Text(
                'Adicione informações para melhorar as respostas.',
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Redefinir Configurações de IA'),
              subtitle: const Text('Restaura para os padrões originais.'),
              trailing: Icon(Icons.restore),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
