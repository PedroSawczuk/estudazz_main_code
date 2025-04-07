import 'package:get/get.dart';
import '../views/homePage.dart';
import '../views/tasks/allTasksPage.dart';
import '../views/calendar/calendarPage.dart';
import '../views/studyGroup/studyGroupPage.dart';
import '../views/performance/performancePage.dart';
import '../views/ia/iaPage.dart';
import '../views/settings/settingsPage.dart';
import '../views/profile/profilePage.dart';

class AppRoutes {
  static const String homePage = '/homePage';
  static const String settingsPage = '/settingsPage';
  static const String allTasksPage = '/allTasksPage';
  static const String profilePage = '/profilePage';
  static const String calendarPage = '/calendarPage';
  static const String iaPage = '/iaPage';
  static const String performancePage = '/performancePage'; 
  static const String studyGroupPage = '/studyGroupPage'; 

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
  ];

}