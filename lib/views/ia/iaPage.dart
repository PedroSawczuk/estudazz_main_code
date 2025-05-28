import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/services/ai/aiGeminiServices.dart';
import 'package:flutter/material.dart';

class IaPage extends StatefulWidget {
  const IaPage({super.key});

  @override
  _IaPageState createState() => _IaPageState();
}

class _IaPageState extends State<IaPage> {
  final TextEditingController _messageController = TextEditingController();

  final AiGeminiServices _aiGeminiServices = AiGeminiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: 'Inteligência Artificial',
        showSettingsIAIcon: true,
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            color: ConstColors.blackColor,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    style: TextStyle(color: ConstColors.whiteColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ConstColors.grey900Color,
                      hintText: 'Digite sua mensagem',
                      hintStyle: TextStyle(color: ConstColors.greyColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                ConstSizedBox.w8,
                IconButton(
                  icon: Icon(Icons.send, color: ConstColors.whiteColor),
                  onPressed: () async {
                    final inputText = _messageController.text.trim();

                    if (inputText.isEmpty) {
                      CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'Por favor, digite uma mensagem para enviar a IA.',
                        backgroundColor: ConstColors.redColor,
                      );
                      return;
                    }
                    
                    try {
                      
                      final responseIA = await _aiGeminiServices.generateText(
                        inputText,
                      );

                      print('$responseIA');
                    
                    } catch (e) {

                      CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'Ocorreu um erro ao enviar a mensagem para a IA. $e',
                        backgroundColor: ConstColors.redColor,
                      );

                      print(e);

                    }

                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
