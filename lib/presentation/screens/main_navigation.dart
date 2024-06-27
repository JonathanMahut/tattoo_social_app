import 'package:flutter/material.dart';
import 'package:tattoo_social_app/presentation/screens/chat_list_screen.dart';
import 'package:tattoo_social_app/presentation/screens/create_post_screen.dart';
import 'package:tattoo_social_app/presentation/screens/explore_screen.dart';
import 'package:tattoo_social_app/presentation/screens/home_screen.dart';
import 'package:tattoo_social_app/presentation/screens/profile_page.dart';
import 'package:tattoo_social_app/presentation/widgets/custom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const CreatePostPage(),
    const ChatListPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
