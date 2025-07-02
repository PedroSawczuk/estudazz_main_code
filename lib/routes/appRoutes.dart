import 'package:estudazz_main_code/views/ia/settings/settingsIAPage.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/views/settings/theme/themeSettingsPage.dart';
import 'package:estudazz_main_code/views/settings/user/editDataPage.dart';
import 'package:estudazz_main_code/views/settings/user/myDataPage.dart';
import 'package:estudazz_main_code/views/homePage.dart';
import 'package:estudazz_main_code/views/tasks/allTasksPage.dart';
import 'package:estudazz_main_code/views/calendar/calendarPage.dart';
import 'package:estudazz_main_code/views/studyGroup/studyGroupPage.dart';
import 'package:estudazz_main_code/views/performance/performancePage.dart';
import 'package:estudazz_main_code/views/ia/iaPage.dart';
import 'package:estudazz_main_code/views/settings/settingsPage.dart';
import 'package:estudazz_main_code/views/profile/profilePage.dart';
import 'package:estudazz_main_code/views/auth/signUpPage.dart';
import 'package:estudazz_main_code/views/auth/signInPage.dart';
import 'package:estudazz_main_code/views/auth/forgotPasswordPage.dart';

class AppRoutes {
  static const String homePage = '/homePage';
  static const String settingsPage = '/settingsPage';
  static const String allTasksPage = '/allTasksPage';
  static const String profilePage = '/profilePage';
  static const String calendarPage = '/calendarPage';

  // -------------- IA
  static const String iaPage = '/iaPage';
  static const String settingsAIPage = '/settingsAIPage';
  
  static const String performancePage = '/performancePage';
  static const String studyGroupPage = '/studyGroupPage';

  static const String myDataPage = '/myDataPage';
  static const String editDataPage = '/editDataPage';
  static const String themeSettingsPage = '/themeSettingsPage';

  static const String signUpPage = '/signUpPage';
  static const String signInPage = '/signInPage';
  static const String forgotPasswordPage = '/forgotPasswordPage';

  static final routes = [
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: settingsPage, page: () => SettingsPage()),
    GetPage(name: studyGroupPage, page: () => StudyGroupPage()),
    GetPage(name: allTasksPage, page: () => AllTasksPage()),
    GetPage(name: profilePage, page: () => ProfilePage()),
    GetPage(name: calendarPage, page: () => CalendarPage()),
    GetPage(name: performancePage, page: () => PerformancePage()),
    
    // -------------- IA
    GetPage(name: iaPage, page: () => IaPage()),
    GetPage(name: settingsAIPage, page: () => SettingsAIPage()),

    // -------------- SETTINGS
    GetPage(name: myDataPage, page: () => MyDataPage()),
    GetPage(name: editDataPage, page: () => EditDataPage()),

    // -------------- THEME
    GetPage(name: themeSettingsPage, page: () => ThemeSettingsPage()),

    // -------------- AUTH
    GetPage(name: signUpPage, page: () => SignUpPage()),
    GetPage(name: signInPage, page: () => SignInPage()),
    GetPage(name: forgotPasswordPage, page: () => ForgotPasswordPage()),
  ];
}
