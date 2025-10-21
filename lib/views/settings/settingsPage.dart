
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
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadNotifications();
  }

  // Load theme from shared preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool('isDarkMode') ?? Get.isDarkMode;
    setState(() {
      isDarkMode = dark;
    });
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  // Save theme to shared preferences
  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  // Load notification settings from shared preferences
  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('notificationsEnabled') ?? true;
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Configurações'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Section
          _buildSectionHeader('Conta'),
          _buildAccountListTile(),
          const Divider(),

          // App Settings Section
          _buildSectionHeader('Configurações do App'),
          _buildNotificationsSwitch(),
          _buildDarkModeSwitch(),
          const Divider(),

          // Logout and Delete Account Section
          _buildLogoutListTile(),
          const SizedBox(height: 20),
          _buildDeleteAccountButton(),
        ],
      ),
    );
  }

  // Section header widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  // 'My Data' list tile
  Widget _buildAccountListTile() {
    return ListTile(
      leading: const Icon(Icons.person),
      title: const Text('Meus Dados'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Get.toNamed(AppRoutes.myDataPage);
      },
    );
  }

  // Notifications switch
  Widget _buildNotificationsSwitch() {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications),
      title: const Text('Receber notificações'),
      value: _notificationsEnabled,
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
    );
  }

  // Dark mode switch
  Widget _buildDarkModeSwitch() {
    return SwitchListTile(
      secondary: const Icon(Icons.dark_mode),
      title: const Text('Tema Escuro'),
      value: isDarkMode,
      onChanged: (value) {
        setState(() {
          isDarkMode = value;
        });
        Get.changeThemeMode(
          value ? ThemeMode.dark : ThemeMode.light,
        );
        _saveTheme(value);
      },
    );
  }

  // Logout list tile
  Widget _buildLogoutListTile() {
    return ListTile(
      leading: const Icon(Icons.logout, color: ConstColors.redColor),
      title: const Text('Sair', style: TextStyle(color: ConstColors.redColor)),
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
    );
  }

  // Delete account button
  Widget _buildDeleteAccountButton() {
    return Center(
      child: TextButton(
        onPressed: () => showDeleteAccountDialog(context),
        style: TextButton.styleFrom(
          foregroundColor: ConstColors.redColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: ConstColors.redColor),
          ),
        ),
        child: const Text(
          'Deletar Conta',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
