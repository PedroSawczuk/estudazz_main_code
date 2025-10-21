import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  ThemeMode? _selectedThemeMode;

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = AppTheme.currentThemeMode;
  }

  void _changeTheme(ThemeMode? value) {
    setState(() {
      _selectedThemeMode = value;
      final newThemeMode = value ?? ThemeMode.system;
      Get.changeThemeMode(newThemeMode);
      AppTheme.currentThemeMode = newThemeMode; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Configurações de Tema'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<ThemeMode>(
                value: _selectedThemeMode,
                onChanged: _changeTheme,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text("Padrão do Sistema"),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text("Modo Claro"),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text("Modo Escuro"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
