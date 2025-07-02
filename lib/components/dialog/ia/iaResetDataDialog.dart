import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IAResetConfirmationDialog extends StatelessWidget {
  const IAResetConfirmationDialog({super.key});

  Future<void> _deleteIAData(BuildContext context) async {
    final uid = await GetUserData.getUserUid();
    if (uid == null) return;

    await FirebaseFirestore.instance.collection('ia-data').doc(uid).delete();

    Get.back();
    CustomSnackBar.show(
      title: 'Sucesso!',
      message: 'Dados da IA foram resetados.',
      backgroundColor: ConstColors.greenColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Redefinir dados da IA'),
      content: Text(
        'Tem certeza que deseja apagar os dados personalizados da IA?',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => _deleteIAData(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: ConstColors.whiteColor,
            backgroundColor: ConstColors.redColor,
          ),
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
