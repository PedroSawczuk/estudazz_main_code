import 'package:estudazz_main_code/components/cards/user/userInfoCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/controllers/user/userController.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksRepository.dart';
import 'package:estudazz_main_code/utils/formatter/dateFormatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final TasksRepository _tasksRepository = TasksRepository();
  final uid = FirebaseAuth.instance.currentUser?.uid;

  ProfilePage({super.key});

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
                    backgroundImage: userData.photoUrl.isNotEmpty
                        ? NetworkImage(userData.photoUrl)
                        : AssetImage('assets/images/no-profile-photo.png')
                            as ImageProvider,
                  ),
                ),

                ConstSizedBox.h10,

                userData.displayName.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            userData.displayName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          ConstSizedBox.h5,
                          Text(
                            '@${userData.username}',
                            style: TextStyle(
                                fontSize: 16, color: ConstColors.greyColor),
                          ),
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
                  style: TextStyle(fontSize: 16, color: ConstColors.greyColor),
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
                StreamBuilder<Map<String, int>>(
                  stream: _tasksRepository.getTasksStats(uid!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Erro ao carregar estatísticas');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('Nenhuma tarefa encontrada');
                    }

                    final data = snapshot.data!;
                    final total = data['total'] ?? 0;
                    final completed = data['completed'] ?? 0;
                    final completionRate =
                        total > 0 ? (completed / total) * 100 : 0.0;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              UserInfoCard(
                                infoName: 'Tarefas Concluídas',
                                iconData: Icons.task_alt,
                                infoValue: completed.toString(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              UserInfoCard(
                                infoName: 'Desempenho (%)',
                                iconData: Icons.bar_chart,
                                infoValue: completionRate.toStringAsFixed(0),
                              ),
                              UserInfoCard(
                                infoName: 'Instituição',
                                iconData: Icons.school_outlined,
                                infoValue: userData.institution,
                              ),
                            ],
                          ),
                        ),
                        ConstSizedBox.h20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              UserInfoCard(
                                infoName: 'Curso',
                                iconData: Icons.menu_book_outlined,
                                infoValue: userData.course,
                              ),
                              UserInfoCard(
                                infoName: 'Graduação',
                                iconData: Icons.calendar_today_outlined,
                                infoValue: userData.expectedGraduation,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
