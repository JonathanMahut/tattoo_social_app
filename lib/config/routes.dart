import 'package:flutter/material.dart';
import 'package:tattoo_social_app/screens/auth_screen.dart';
import 'package:tattoo_social_app/screens/feed_screen.dart';
import 'package:tattoo_social_app/screens/home_screen.dart';
import 'package:tattoo_social_app/screens/profile_screen.dart';
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
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case feed:
        return MaterialPageRoute(builder: (_) => const FeedScreen());
      case profile:
        // Vous pouvez passer des arguments si nécessaire
        // final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case tattooSwipe:
        return MaterialPageRoute(builder: (_) => const TattooSwipeScreen());
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
