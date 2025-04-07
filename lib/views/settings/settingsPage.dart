
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
    Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(titleAppBar: 'SETTINGS'),
    body: Column(children: [Text('SETTINGS')]),
  );
  } 
}
