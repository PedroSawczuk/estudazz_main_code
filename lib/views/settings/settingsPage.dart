import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estudazz_main_code/components/cards/settings/settingsCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/services/auth/saveUserLocal.dart';
import 'package:estudazz_main_code/utils/user/userDeleteAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool('isDarkMode') ?? Get.isDarkMode;
    setState(() {
      isDarkMode = dark;
    });
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

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
                    icon: Icons.person,
                    title: "Meus Dados",
                    onTap: () {
                      Get.toNamed(AppRoutes.myDataPage);
                    },
                  ),
                  SettingsCard(
                    icon: Icons.notifications,
                    title: "Notificações",
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationsPage);
                    },
                  ),

                  SettingsCard(
                    icon: Icons.dark_mode,
                    title: "Tema Escuro",
                    child: SwitchListTile(
                      value: isDarkMode,
                      title: Text("Tema Escuro"),
                      secondary: Icon(Icons.dark_mode),
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                        });
                        Get.changeThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                        _saveTheme(value);
                      },
                    ),
                  ),

                  SettingsCard(
                    icon: Icons.language,
                    title: "Idioma",
                    onTap: () {
                      CustomSnackBar.show(
                        title: 'Em breve',
                        message: 'Configurações de idiomas em breve.',
                        backgroundColor: ConstColors.blueColor,
                      );
                    },
                  ),
                  SettingsCard(
                    icon: Icons.logout,
                    title: "Sair",
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await SaveUserLocal.clearUser();
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
                style: TextButton.styleFrom(
                  foregroundColor: ConstColors.redColor,
                ),
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
