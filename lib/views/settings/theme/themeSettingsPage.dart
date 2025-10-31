import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/services/theme/themeService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  ThemeMode? _selectedThemeMode;
  final ThemeService _themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> _saveAndApplyTheme(ThemeMode value) async {
    Get.changeThemeMode(value);
    await _themeService.saveThemeMode(value);
  }

  void _changeTheme(ThemeMode? value) {
    if (value == null) return;

    setState(() {
      _selectedThemeMode = value;
    });

    _saveAndApplyTheme(value);
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
                items: const [
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
