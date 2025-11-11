import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class StudyRoomPage extends StatelessWidget {
  const StudyRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppBar: 'Sala de Estudos',
      ),
      body: const Center(
        child: Text('Página da Sala de Estudos'),
      ),
    );
  }
}
