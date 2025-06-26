import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/components/ia/aiResponseMessage.dart';
import 'package:estudazz_main_code/components/ia/userInputMessage.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/models/ia/iaChatMessage.dart';
import 'package:estudazz_main_code/services/ia/iaGeminiServices.dart';
import 'package:flutter/material.dart';

class IaPage extends StatefulWidget {
  const IaPage({super.key});

  @override
  _IaPageState createState() => _IaPageState();
}

class _IaPageState extends State<IaPage> {
  final TextEditingController _messageController = TextEditingController();
  final AiGeminiServices _aiGeminiServices = AiGeminiServices();

  final List<ChatModel> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: 'Inteligência Artificial',
        showSettingsIAIcon: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return message.isUser
                    ? UserInputMessage(text: message.text)
                    : AIResponseMessage(text: message.text);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                    final userInputText = _messageController.text.trim();

                    if (userInputText.isEmpty) {
                      CustomSnackBar.show(
                        title: 'Erro!',
                        message:
                            'Por favor, digite uma mensagem para enviar à IA.',
                        backgroundColor: ConstColors.redColor,
                      );
                      return;
                    }

                    setState(() {
                      _messages.insert(
                        0,
                        ChatModel(text: userInputText, isUser: true),
                      );
                    });

                    _messageController.clear();

                    try {
                      final responseIA = await _aiGeminiServices.generateText(
                        userInputText,
                      );

                      setState(() {
                        _messages.insert(
                          0,
                          ChatModel(text: responseIA, isUser: false),
                        );
                      });
                    } catch (e) {
                      CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'Erro ao enviar mensagem para a IA. $e',
                        backgroundColor: ConstColors.redColor,
                      );
                    }
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
