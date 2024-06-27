import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_colors.dart';

class StoryBubble extends StatelessWidget {
  const StoryBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.accent,
                  AppColors.primary,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage('https://placeholder.com/150'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text('Username', overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
