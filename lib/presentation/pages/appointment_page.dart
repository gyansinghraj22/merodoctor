

import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11:20', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Welcome Back Appointments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            
            // Real section
            _buildSectionHeader('Real'),
            _buildStatusRow('Upcoming'),
            _buildStatusRow('Cancelled'),
            Divider(),
            
            // Today section
            _buildSectionHeader('Today'),
            _buildAppointmentCard(
              name: 'Dr. Andrea H.',
              qualification: 'MD, DNB (Field)',
              time: '09:00 - 10:00 AM',
              type: 'Showbiker',
            ),
            _buildAppointmentCard(
              name: 'Dr. Amin Yusha',
              qualification: 'Diploma Candice (F)',
              time: '09:00 - 10:00 AM',
              type: 'Showbiker',
            ),
            _buildAppointmentCard(
              name: 'Dr. Eon Morgan',
              qualification: 'MD& TDB (BCPS)',
              time: '09:00 - 10:00 AM',
              type: 'Showbiker',
            ),
            Divider(),
            
            // Tomorrow section
            _buildSectionHeader('Tomorrow'),
            _buildAppointmentCard(
              name: 'Dr. Jerry Jones',
              qualification: 'MBBS, MD (Neutralized)',
              time: '09:00 - 10:00 AM',
              type: 'Showbiker',
            ),
            _buildAppointmentCard(
              name: 'Dr. Eon Morgan',
              qualification: 'MD, MMA',
              time: '',
              type: '',
            ),
            Divider(),
            
            // Home section
            _buildSectionHeader('Home'),
            _buildHomeOption('Doctors'),
            _buildHomeOption('Masters'),
            _buildHomeOption('News'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatusRow(String status) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.grey),
          SizedBox(width: 8),
          Text(status),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String name,
    required String qualification,
    required String time,
    required String type,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(qualification),
            if (time.isNotEmpty && type.isNotEmpty) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  Text(type),
                  Spacer(),
                  Text(time),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHomeOption(String option) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        option,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}