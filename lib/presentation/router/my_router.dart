import 'package:super_do/presentation/screens/intro/loading_splash_scree.dart';
import 'package:flutter/material.dart';

class MyRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return getHomeScreenRoute();
      default:
        return getHomeScreenRoute();
    }
  }

  Route getHomeScreenRoute() {
    return MaterialPageRoute(builder: (context) => LoadingSplashScreen());
  }
}
