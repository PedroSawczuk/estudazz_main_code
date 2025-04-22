import 'package:estudazz_main_code/components/cards/userInfoCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
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
              children: [
                UserInfoCard(label: "Nome", value: data['display_name'] ?? ''),
                UserInfoCard(label: "Username", value: data['username'] ?? ''),
                UserInfoCard(label: "Email", value: data['email'] ?? ''),
                UserInfoCard(
                  label: "Data de Nascimento",
                  value: data['birth_date'] ?? '',
                ),
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
                ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(AppRoutes.editDataPage);
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text("Editar Dados"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFED820E),
                    foregroundColor: Colors.white,
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
