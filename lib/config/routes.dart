import 'package:flutter/material.dart';
import 'package:tattoo_social_app/screens/feed_screen.dart';
import 'package:tattoo_social_app/screens/tattoo_swipe_screen.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String home = '/';
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String tattooSwipe = '/tattoo-swipe';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case feed:
        return MaterialPageRoute(builder: (_) => FeedScreen());
      case profile:
        // Vous pouvez passer des arguments si nécessaire
        // final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case tattooSwipe:
        return MaterialPageRoute(builder: (_) => TattooSwipeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
