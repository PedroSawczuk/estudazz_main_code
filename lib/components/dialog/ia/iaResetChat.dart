import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

class IAResetChat extends StatelessWidget {
  const IAResetChat({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Resetar conversa da IA'),
      content: Text(
        'Tem certeza que deseja apagar todas as mensagens da conversa com a IA?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: ConstColors.whiteColor,
            backgroundColor: ConstColors.redColor,
          ),
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
