import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListItem extends StatelessWidget {
  final String userId;
  final String username;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String profileImageUrl;
  final VoidCallback onTap;

  const ChatListItem({
    Key? key,
    required this.userId,
    required this.username,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.profileImageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profileImageUrl),
      ),
      title: Text(
        username,
        style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lastMessage,
            style: AppTextStyles.body1.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            timeago.format(lastMessageTime),
            style: AppTextStyles.body1.copyWith(color: Colors.grey),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
