import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class StudyGroupPage extends StatelessWidget {
  const StudyGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Grupo de Estudos'),
      body: Column(children: [Text('Grupo de Estudos'),]),
    );
  }
}
