import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final bool seen;
  final bool isMe;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.seen,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(image), radius: 28),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          seen
              ? const Icon(Icons.check_circle, color: Colors.green, size: 18)
              : const Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey,
                size: 16,
              ),
        ],
      ),
    );
  }
}
