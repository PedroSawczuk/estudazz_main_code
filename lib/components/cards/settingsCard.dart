import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

Widget SettingsCard(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    elevation: 4,
    child: ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color ?? ConstColors.black87Color,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: onTap,
    ),
  );
}
