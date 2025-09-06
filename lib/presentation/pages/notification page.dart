import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for the page
      appBar: AppBar(
        backgroundColor: Colors.grey[100], // Match body background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: const [
          NotificationItem(
            icon: Icons.info_outline,
            iconColor: Colors.blue,
            title: 'Appointment Update',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          NotificationItem(
            icon: Icons.credit_card,
            iconColor: Colors.green,
            title: 'Credit Card Connected',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          NotificationItem(
            icon: Icons.flash_on,
            iconColor: Colors.orange,
            title: 'New Services Available',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          NotificationItem(
            icon: Icons.calendar_today,
            iconColor: Colors.purple,
            title: 'Rescheduled',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          NotificationItem(
            icon: Icons.info_outline,
            iconColor: Colors.blue,
            title: 'Appointment Update',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          NotificationItem(
            icon: Icons.push_pin_outlined,
            iconColor: Colors.teal,
            title: 'New Service Available',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          NotificationItem(
            icon: Icons.check_circle_outline,
            iconColor: Colors.lightGreen,
            title: 'Appointment Success',
            description: 'Eion Morgan is a dedicated pediatrician with over 15 years...',
            time: 'Just Now',
          ),
          // Add more NotificationItem widgets as needed
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB Tapped!')),
          );
        },
        backgroundColor: Colors.black87, // Dark color for the FAB
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
        ),
        child: const Icon(Icons.add, color: Colors.white), // Example icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position at bottom end
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String time;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1), // Light background for icon
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2, // Limit description to 2 lines
                    overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Time
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
