import 'package:classmatescorner/Screens/LoginPage.dart';
import 'package:classmatescorner/Screens/StartPage.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static String startPage = '/';

  static Map<String, WidgetBuilder> route = {
    startPage: (context) => StartPage(),
  };
}
