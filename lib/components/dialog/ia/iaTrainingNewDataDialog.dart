import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IATrainingNewDataDialog extends StatefulWidget {
  IATrainingNewDataDialog({super.key});

  @override
  State<IATrainingNewDataDialog> createState() =>
      _IATrainingNewDataDialogState();
}

class _IATrainingNewDataDialogState extends State<IATrainingNewDataDialog> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final snapshot = await _firestore.collection('ia-data').doc(uid).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null && data['data'] != null) {
        setState(() {
          _textController.text = data['data'];
        });
      }
    }
  }

  void _confirmIANewData() async {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      await _firestore.collection('ia-data').doc(uid).set({
        'data': text,
        'uid': uid,
        'email': _auth.currentUser?.email ?? '',
        'created_at': DateTime.now().toIso8601String(),
      });

      Navigator.of(context).pop();

      print(text);
    } else {
      CustomSnackBar.show(
        title: 'Erro!',
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
