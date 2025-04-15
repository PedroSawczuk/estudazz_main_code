import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';

void showDeleteAccountDialog(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                text:
                    "Digite seu e-mail para confirmar a exclusão da conta:\n\n",
                children: [
                  TextSpan(
                    text: "${currentUser?.email ?? '[email não disponível]'}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Excluir"),
            onPressed: () async {
              if (emailController.text.trim() == currentUser?.email) {
                try {
                  final uid = currentUser!.uid;

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .delete();

                  await currentUser.delete();

                  Navigator.of(context).pop();

                  Get.snackbar(
                    "Conta excluída",
                    "Sua conta foi deletada com sucesso.",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  Get.offAllNamed(AppRoutes.signInPage);
                } catch (e) {
                  Navigator.of(context).pop();
                  Get.snackbar(
                    "Erro",
                    "Falha ao excluir conta: $e",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              } else {
                Get.snackbar(
                  "Erro",
                  "E-mail incorreto!",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
      );
    },
  );
}
