import 'package:flutter/material.dart';
import 'package:tattoo_social_app/presentation/screens/chat_screen.dart';
import 'package:tattoo_social_app/presentation/widgets/chat_list_items.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  // Replace with your actual chat data
  final List<Map<String, dynamic>> _chatData = [
    {
      'userId': 'user1',
      'username': 'John Doe',
      'lastMessage': 'Hey, how are you?',
      'lastMessageTime': DateTime.now().subtract(const Duration(hours: 1)),
      'profileImageUrl': 'https://placeholder.com/150',
    },
    {
      'userId': 'user2',
      'username': 'Jane Doe',
      'lastMessage': 'I\'m good, thanks!',
      'lastMessageTime': DateTime.now().subtract(const Duration(minutes: 30)),
      'profileImageUrl': 'https://placeholder.com/150',
    },
    // Add more chat data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: _chatData.length,
        itemBuilder: (context, index) {
          final chat = _chatData[index];
          return ChatListItem(
            userId: chat['userId'],
            username: chat['username'],
            lastMessage: chat['lastMessage'],
            lastMessageTime: chat['lastMessageTime'],
            profileImageUrl: chat['profileImageUrl'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    userId: chat['userId'],
                    username: chat['username'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
