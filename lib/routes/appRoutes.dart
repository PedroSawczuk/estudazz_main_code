import 'package:get/get.dart';
import '../views/homePage.dart';

class AppRoutes {
  static const String homePage = '/homePage';

  static final routes = [
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
  ];
}