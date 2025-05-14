import 'package:estudazz_main_code/components/cards/settingsCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/utils/user/userDeleteAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Configurações'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SettingsCard(
                    context,
                    icon: Icons.person,
                    title: "Meus Dados",
                    onTap: () {
                      Get.toNamed(AppRoutes.myDataPage);
                    },
                  ),
                  SettingsCard(
                    context,
                    icon: Icons.notifications,
                    title: "Notificações",
                    onTap: () {},
                  ),
                  SettingsCard(
                    context,
                    icon: Icons.dark_mode,
                    title: "Tema",
                    onTap: () {
                      Get.toNamed(AppRoutes.themeSettingsPage);
                    },
                  ),
                  SettingsCard(
                    context,
                    icon: Icons.language,
                    title: "Idioma",
                    onTap: () {},
                  ),
                  SettingsCard(
                    context,
                    icon: Icons.logout,
                    title: "Sair",
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed(AppRoutes.signInPage);
                      CustomSnackBar.show(
                        title: 'Desconectado',
                        message: 'Você foi desconectado com sucesso.',
                        backgroundColor: ConstColors.greenColor,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextButton(
                onPressed: () => showDeleteAccountDialog(context),
                style: TextButton.styleFrom(foregroundColor: ConstColors.redColor),
                child: Text(
                  "Deletar Conta",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ConstColors.redColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
