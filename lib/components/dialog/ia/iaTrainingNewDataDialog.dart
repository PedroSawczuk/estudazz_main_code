import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:flutter/material.dart';

class IATrainingNewDataDialog extends StatefulWidget {
  const IATrainingNewDataDialog({super.key});

  @override
  State<IATrainingNewDataDialog> createState() =>
      _IATrainingNewDataDialogState();
}

class _IATrainingNewDataDialogState extends State<IATrainingNewDataDialog> {
  final TextEditingController _textController = TextEditingController();

  void _confirmIANewData() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      Navigator.of(context).pop();
      print(text);
    } else {
      CustomSnackBar.show(
        title: 'Erro',
        message: 'Campo não pode ficar vazio.',
        backgroundColor: ConstColors.redColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Treinar IA com Novos Dados'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Adicione informações para melhorar as respostas da IA.'),
          ConstSizedBox.h12,
          TextField(
            controller: _textController,
            minLines: 5,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Digite aqui...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _confirmIANewData, child: Text('Salvar')),
      ],
    );
  }
}
