import 'package:flutter/material.dart';
import 'package:merodoctor/presentation/widgets/chat_tile.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  final List<Map<String, dynamic>> chats = const [
    {
      'name': 'Eyal Ofer',
      'message': 'Eion Morgan is a dedicated pediatrician with over 15...',
      'time': 'Just Now',
      'image': 'assets/images/eyal.png',
      'seen': false,
      'isMe': false,
    },
    {
      'name': 'Jeff Yass',
      'message': 'You: Eion Morgan is a dedicated pediatrician with...',
      'time': '2 hours ago',
      'image': 'assets/images/jeff.png',
      'seen': false,
      'isMe': true,
    },
    {
      'name': 'Yen Shipley',
      'message': 'Eion Morgan is a dedicated pediatrician with over 15...',
      'time': 'Yesterday',
      'image': 'assets/images/yen.png',
      'seen': false,
      'isMe': false,
    },
    {
      'name': 'Pedramine G.',
      'message':
          'Eion Morgan is a dedicated pediatrician with over 15 years...',
      'time': 'Monday',
      'image': 'assets/images/pedramine.png',
      'seen': true,
      'isMe': false,
    },
    {
      'name': 'Kimberly J.',
      'message':
          'Eion Morgan is a dedicated pediatrician with over 15 years...',
      'time': 'Saturday',
      'image': 'assets/images/kimberly.png',
      'seen': true,
      'isMe': false,
    },
    {
      'name': 'Stefan Persson',
      'message': 'You: Eion Morgan is a dedicated pediatrician with...',
      'time': '02, Oct',
      'image': 'assets/images/stefan.png',
      'seen': true,
      'isMe': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'Inbox',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.search, color: Colors.black),
            const SizedBox(width: 16),
            const Icon(Icons.notifications_none, color: Colors.black),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatTile(
            name: chat['name'],
            message: chat['message'],
            time: chat['time'],
            image: chat['image'],
            seen: chat['seen'],
            isMe: chat['isMe'],
          );
        },
      ),
    );
  }
}
