import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_colors.dart';
import 'package:tattoo_social_app/app/theme/app_text_styles.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://placeholder.com/150'),
            ),
            title: Text('Username',
                style:
                    AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
            subtitle: const Text('Location'),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
          Image.network(
            'https://placeholder.com/500x500',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1,234 likes',
                    style: AppTextStyles.body1
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.body1,
                    children: [
                      TextSpan(
                          text: 'Username ',
                          style: AppTextStyles.body1
                              .copyWith(fontWeight: FontWeight.bold)),
                      const TextSpan(text: 'This is a caption for the post...'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text('View all 123 comments',
                    style: AppTextStyles.body1
                        .copyWith(color: AppColors.textLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
