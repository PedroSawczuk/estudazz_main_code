import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDataPage extends StatelessWidget {
  MyDataPage({super.key});

  Future<DocumentSnapshot> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Meus Dados'),
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(),
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
                _buildInfoRow("Nome", data['display_name'] ?? ''),
                _buildInfoRow("Username", data['username'] ?? ''),
                _buildInfoRow("Email", data['email'] ?? ''),
                _buildInfoRow("Data de Nascimento", data['birth_date'] ?? ''),
                _buildInfoRow("Instituição", data['institution'] ?? ''),
                _buildInfoRow("Curso", data['course'] ?? ''),
                _buildInfoRow(
                  "Conclusão Prevista",
                  data['expected_graduation'] ?? '',
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }
}
