import 'package:estudazz_main_code/components/cards/user/userInfoCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Perfil'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstSizedBox.h20,
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'assets/images/no-profile-photo.png',
                ),
              ),
            ),
            ConstSizedBox.h10,
            Text(
              'Pedro Sawczuk',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            ConstSizedBox.h5,
            Text(
              'pedrosawczuk53@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            ConstSizedBox.h30,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UserInfoCard(
                    infoName: 'Tarefas Concluídas',
                    iconData: Icons.task_alt,
                    infoValue: 30.toString(),
                  ),
                  UserInfoCard(
                    infoName: 'Conta Criada',
                    iconData: Icons.calendar_today,
                    infoValue: '07/06/2025',
                  ),
                ],
              ),
            ),
            ConstSizedBox.h20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UserInfoCard(
                    infoName: 'Grupos de Estudo',
                    iconData: Icons.groups,
                    infoValue: '43',
                  ),
                  UserInfoCard(
                    infoName: 'Desempenho (%)',
                    iconData: Icons.bar_chart,
                    infoValue: '43',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
