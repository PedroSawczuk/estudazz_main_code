import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/utils/user/userAuthCheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titleAppBar;
  final bool showPersonIcon;
  final bool showSettingsIAIcon;
  final bool showMembersIcon;
  final VoidCallback? onMembersIconTap;
  final PreferredSizeWidget? bottom;

  CustomAppBar({
    Key? key,
    required this.titleAppBar,
    this.showPersonIcon = false,
    this.showSettingsIAIcon = false,
    this.showMembersIcon = false,
    this.onMembersIconTap,
    this.bottom,
  }) : preferredSize = Size.fromHeight(56.0 + (bottom?.preferredSize.height ?? 0.0)),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(titleAppBar),
      ),
      actions: [
        if (showMembersIcon)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.group),
              onPressed: onMembersIconTap,
              tooltip: 'Ver Membros',
            ),
          ),
        if (showSettingsIAIcon)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed:
                  () => {
                    AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated:
                          () => Get.toNamed(AppRoutes.settingsAIPage),
                    ),
                  },
            ),
          ),
        if (showPersonIcon)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed:
                  () => {
                    AuthGuard.handleAuthenticatedAction(
                      context: context,
                      onAuthenticated: () => Get.toNamed(AppRoutes.profilePage),
                    ),
                  },
            ),
          ),
      ],
      bottom: bottom,
    );
  }
}
