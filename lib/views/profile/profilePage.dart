import 'package:estudazz_main_code/components/cards/user/userInfoCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/controllers/user/userController.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/utils/formatter/dateFormatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Seu Perfil'),
      body: FutureBuilder(
        future: UserController().fetchUserData(),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return const Center(
              child: Text(
                'Erro ao carregar dados do usuário \n Contate o suporte.',
              ),
            );
          }

          final userData = userSnapshot.data!;

          final creationDate = DateFormatter(
            FirebaseAuth.instance.currentUser!.metadata.creationTime!.toLocal(),
          );

          return SingleChildScrollView(
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

                userData.displayName.isNotEmpty
                    ? Column(
                      children: [
                        Text(
                          userData.displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        ConstSizedBox.h5,
                      ],
                    )
                    : Text(
                      'Sem nome definido',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                Text(
                  userData.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                ConstSizedBox.h5,

                userData.profileCompleted
                    ? Text(
                      'Seu perfil está completo!',
                      style: TextStyle(
                        fontSize: 16,
                        color: ConstColors.greenColor,
                      ),
                    )
                    : ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.myDataPage);
                      },
                      child: Text('Complete seu perfil'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ConstColors.redColor,
                        foregroundColor: ConstColors.whiteColor,
                      ),
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
                        infoValue: creationDate,
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
          );
        },
      ),
    );
  }
}
