import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? child; 

  const SettingsCard({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      child:
          child != null
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: child,
              )
              : ListTile(
                leading: Icon(icon, color: Theme.of(context).iconTheme.color),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color:
                        Theme.of(context).textTheme.bodyLarge?.color ??
                        ConstColors.black87Color,
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
}
