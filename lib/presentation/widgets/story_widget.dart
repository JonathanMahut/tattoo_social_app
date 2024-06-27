import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_colors.dart';
import 'package:tattoo_social_app/app/theme/app_text_styles.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) {
          // Pause story
        },
        onTapUp: (_) {
          // Resume story
        },
        onTapCancel: () {
          // Resume story
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://placeholder.com/1080x1920',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(
                  5,
                  (index) => Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: index == 0
                          ? AppColors.accent
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 16,
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://placeholder.com/150'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Username',
                    style: AppTextStyles.body1.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Send message',
                        hintStyle:
                            AppTextStyles.body1.copyWith(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      style: AppTextStyles.body1.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
