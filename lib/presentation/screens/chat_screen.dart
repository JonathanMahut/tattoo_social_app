import 'package:flutter/material.dart';
import 'package:tattoo_social_app/app/theme/app_text_styles.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String username;

  const ChatScreen({Key? key, required this.userId, required this.username})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Replace with your data

  @override
  void initState() {
    super.initState();
    // Load chat messages from database or API
    _loadChatMessages();
  }

  Future<void> _loadChatMessages() async {
    // Replace with your actual chat message loading logic
    // Example using a mock data source
    setState(() {
      _messages.addAll([
        {
          'senderId': 'user1',
          'message': 'Hello!',
          'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
        },
        {
          'senderId': 'user2',
          'message': 'Hi there!',
          'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        // Add more messages here
      ]);
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      // Send message to database or API
      // Example using a mock data source
      setState(() {
        _messages.add({
          'senderId': 'user2', // Replace with current user ID
          'message': _messageController.text,
          'timestamp': DateTime.now(),
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://placeholder.com/150'), // Replace with user profile image
            ),
            const SizedBox(width: 8),
            Text(widget.username),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isCurrentUser = message['senderId'] ==
                    'user2'; // Replace with current user ID
                return Align(
                  alignment: isCurrentUser
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isCurrentUser)
                          Text(
                            widget.username,
                            style: AppTextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        Text(
                          message['message'],
                          style: AppTextStyles.body1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${message['timestamp']}',
                          style: AppTextStyles.body1.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
