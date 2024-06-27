import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_colors.dart';
import 'package:tattoo_social_app/app/theme/app_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textLight,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(AppIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.create),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.profile),
          label: 'Profile',
        ),
      ],
    );
  }
}
