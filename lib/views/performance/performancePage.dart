import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Desempenho'),
      body: Column(children: [Text('Desempenho'),]),
    );
  }
}
