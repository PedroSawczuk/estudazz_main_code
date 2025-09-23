import 'package:estudazz_main_code/components/cards/settings/settingsCard.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/services/auth/saveUserLocal.dart';
import 'package:estudazz_main_code/utils/user/userDeleteAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'pt-br';

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadNotifications();
    _loadLanguage();
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

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('notificationsEnabled') ?? true;
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('selectedLanguage') ?? 'pt-br';
    setState(() {
      _selectedLanguage = lang;
    });
  }

  Future<void> _saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', value);
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
                    child: SwitchListTile(
                      value: _notificationsEnabled,
                      title: Text("Receber notificações"),
                      secondary: Icon(Icons.notifications),
                      onChanged: (value) async {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('notificationsEnabled', value);
                        if (value) {
                          try {
                            await OneSignal.User.pushSubscription.optIn();
                          } catch (e) {
                            CustomSnackBar.show(
                              title: 'Erro',
                              message: 'Não foi possível ativar as notificações.',
                              backgroundColor: ConstColors.redColor,
                            );
                          }
                        } else {
                          try {
                            await OneSignal.User.pushSubscription.optOut();
                          } catch (e) {
                            CustomSnackBar.show(
                              title: 'Erro',
                              message: 'Não foi possível desativar as notificações.',
                              backgroundColor: ConstColors.redColor,
                            );
                          }
                        }
                      },
                    ),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: Icon(Icons.arrow_drop_down, color: ConstColors.blueColor),
                        items: [
                          DropdownMenuItem(
                            value: 'pt-br',
                            child: Row(
                              children: [
                                Image.network(
                                  'https://flagcdn.com/w20/br.png',
                                  width: 24,
                                  height: 18,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.flag, size: 20),
                                ),
                                SizedBox(width: 8),
                                Text('Português (Brasil)'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'es',
                            child: Row(
                              children: [
                                Image.network(
                                  'https://flagcdn.com/w20/es.png',
                                  width: 24,
                                  height: 18,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.flag, size: 20),
                                ),
                                SizedBox(width: 8),
                                Text('Español'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'en',
                            child: Row(
                              children: [
                                Image.network(
                                  'https://flagcdn.com/w20/gb.png',
                                  width: 24,
                                  height: 18,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.flag, size: 20),
                                ),
                                SizedBox(width: 8),
                                Text('English'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedLanguage = value;
                            });
                            _saveLanguage(value);
                          }
                        },
                      ),
                    ),
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
