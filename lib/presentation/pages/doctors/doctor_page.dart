import 'package:flutter/material.dart';
import 'package:merodoctor/presentation/widgets/doctor_card.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  final List<Map<String, String>> doctors = const [
    {
      'name': 'Dr. Aaliya Y.',
      'specialty': 'MDS, FDS RCPS',
      'fee': '\$50.99',
      'image': 'assets/images/doctor1.png',
    },
    {
      'name': 'Dr. Amira',
      'specialty': 'BDS, Dentistry',
      'fee': '\$50.99',
      'image': 'assets/images/doctor2.png',
    },
    {
      'name': 'Dr. Anna G.',
      'specialty': 'Cardiologist',
      'fee': '\$50.99',
      'image': 'assets/images/doctor3.png',
    },
    {
      'name': 'Dr. Anne.',
      'specialty': 'Hepatology',
      'fee': '\$50.99',
      'image': 'assets/images/doctor4.png',
    },
    {
      'name': 'Dr. Andrea H.',
      'specialty': 'Neurosurgery',
      'fee': '\$50.99',
      'image': 'assets/images/doctor5.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
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
                  'Mr. Williamson',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 16),
            Icon(Icons.filter_list, color: Colors.grey),
          ],
        ),
      ),
      body: Column(
        children: [
          const FilterChips(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return DoctorCard(
                  name: doctor['name']!,
                  specialty: doctor['specialty']!,
                  fee: doctor['fee']!,
                  imagePath: doctor['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Chip(label: Text('Neurologist'), backgroundColor: Colors.greenAccent),
          SizedBox(width: 8),
          Chip(
            label: Text('Neuromedicine'),
            backgroundColor: Colors.lightGreenAccent,
          ),
          SizedBox(width: 8),
          Chip(label: Text('Medicine'), backgroundColor: Colors.grey),
          SizedBox(width: 8),
          Chip(
            label: Text('Psychiatry'),
            backgroundColor: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
  }
}
