import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

class IaPage extends StatefulWidget {
  const IaPage({super.key});

  @override
  _IaPageState createState() => _IaPageState();
}

class _IaPageState extends State<IaPage> {
  final TextEditingController _messageController = TextEditingController();

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
            color: Colors.black,
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
                const SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send, color: ConstColors.whiteColor),
                  onPressed: () {
                    print('Mensagem enviada: ${_messageController.text}');
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
