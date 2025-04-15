import 'package:estudazz_main_code/views/settings/user/editDataPage.dart';
import 'package:estudazz_main_code/views/settings/user/myDataPage.dart';
import 'package:get/get.dart';
import '../views/homePage.dart';
import '../views/tasks/allTasksPage.dart';
import '../views/calendar/calendarPage.dart';
import '../views/studyGroup/studyGroupPage.dart';
import '../views/performance/performancePage.dart';
import '../views/ia/iaPage.dart';
import '../views/settings/settingsPage.dart';
import '../views/profile/profilePage.dart';

import '../views/auth/signUpPage.dart';
import '../views/auth/signInPage.dart';
import '../views/auth/forgotPasswordPage.dart';

class AppRoutes {
  static const String homePage = '/homePage';
  static const String settingsPage = '/settingsPage';
  static const String allTasksPage = '/allTasksPage';
  static const String profilePage = '/profilePage';
  static const String calendarPage = '/calendarPage';
  static const String iaPage = '/iaPage';
  static const String performancePage = '/performancePage'; 
  static const String studyGroupPage = '/studyGroupPage'; 

  static const String myDataPage = '/myDataPage'; 
  static const String editDataPage = '/editDataPage'; 
  
  static const String signUpPage = '/signUpPage'; 
  static const String signInPage = '/signInPage'; 
  static const String forgotPasswordPage = '/forgotPasswordPage'; 

  static final routes = [
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: settingsPage,
      page: () => SettingsPage(),
    ),
    GetPage(
      name: studyGroupPage,
      page: () => StudyGroupPage(),
    ),
    GetPage(
      name: allTasksPage,
      page: () => AllTasksPage(),
    ),
    GetPage(
      name: profilePage,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: calendarPage,
      page: () => CalendarPage(),
    ),
    GetPage(
      name: iaPage,
      page: () => IaPage(),
    ),
    GetPage(
      name: performancePage,
      page: () => PerformancePage(),
    ),

  // -------------- SETTINGS
    GetPage(
      name: myDataPage,
      page: () => MyDataPage(),
    ),
    GetPage(
      name: editDataPage,
      page: () => EditDataPage(),
    ),


  // -------------- AUTH
    GetPage(
      name: signUpPage,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: signInPage,
      page: () => SignInPage(),
    ),
    GetPage(
      name: forgotPasswordPage,
      page: () => ForgotPasswordPage(),
    ),
  ];
}