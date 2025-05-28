import 'package:estudazz_main_code/components/cards/user/userInfoCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/services/user/fetchUserDataService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataPage extends StatelessWidget {
  MyDataPage({super.key});

  final FetchUserDataService _fetchUserDataService = FetchUserDataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Meus Dados'),
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchUserDataService.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Dados não encontrados."));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'assets/images/no-profile-photo.png',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Informações Pessoais',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Divider(thickness: 1),
                SizedBox(height: 8),

                UserInfoCard(label: "Nome", value: data['display_name'] ?? ''),
                UserInfoCard(label: "Username", value: data['username'] ?? ''),
                UserInfoCard(label: "Email", value: data['email'] ?? ''),
                UserInfoCard(
                  label: "Data de Nascimento",
                  value: data['birth_date'] ?? '',
                ),

                SizedBox(height: 13),

                Text(
                  'Informações Acadêmicas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Divider(thickness: 1),
                SizedBox(height: 8),

                UserInfoCard(
                  label: "Instituição",
                  value: data['institution'] ?? '',
                ),
                UserInfoCard(label: "Curso", value: data['course'] ?? ''),
                UserInfoCard(
                  label: "Conclusão Prevista",
                  value: data['expected_graduation'] ?? '',
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.editDataPage);
                    },
                    icon: Icon(Icons.edit, color: ConstColors.whiteColor),
                    label: Text("Editar Dados"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstColors.orangeColor,
                      foregroundColor: ConstColors.whiteColor,
                    ),
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
