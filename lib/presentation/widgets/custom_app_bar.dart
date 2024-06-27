import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_colors.dart';
import 'package:tattoo_social_app/app/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text(
        title,
        style: AppTextStyles.headline1.copyWith(color: AppColors.primary),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: AppColors.text),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.send, color: AppColors.text),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
