import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:flutter/material.dart';

class AllTasksPage extends StatelessWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
     Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(titleAppBar: 'ALL TASKS'),
    body: Column(children: [Text('ALL TASKS')]),
  );
  } 
}
