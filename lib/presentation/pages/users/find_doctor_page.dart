import 'package:flutter/material.dart';

class FindDoctorPage extends StatelessWidget {
  const FindDoctorPage({super.key});

  final List<Map<String, String>> specialties = const [
    {'title': 'Nephrology', 'icon': 'assets/icons/nephrology.png'},
    {'title': 'Anesthesiology', 'icon': 'assets/icons/anesthesiology.png'},
    {'title': 'Orthopedics', 'icon': 'assets/icons/orthopedics.png'},
    {'title': 'Ophthalmology', 'icon': 'assets/icons/ophthalmology.png'},
    {'title': 'Pediatrics', 'icon': 'assets/icons/pediatrics.png'},
    {'title': 'Oncology', 'icon': 'assets/icons/oncology.png'},
    {'title': 'Dermatology', 'icon': 'assets/icons/dermatology.png'},
    {'title': 'Pathology', 'icon': 'assets/icons/pathology.png'},
    {'title': 'Psychiatry', 'icon': 'assets/icons/psychiatry.png'},
    {'title': 'General surgery', 'icon': 'assets/icons/general_surgery.png'},
    {'title': 'Endocrinology', 'icon': 'assets/icons/endocrinology.png'},
    {'title': 'Radiology', 'icon': 'assets/icons/radiology.png'},
    {'title': 'Surgery', 'icon': 'assets/icons/surgery.png'},
    {'title': 'Cardiology', 'icon': 'assets/icons/cardiology.png'},
    {'title': 'Geriatrics', 'icon': 'assets/icons/geriatrics.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Find Your Doctor",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: specialties.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 24,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final item = specialties[index];
            return CategoryTile(title: item['title']!, iconPath: item['icon']!);
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String title;
  final String iconPath;

  const CategoryTile({super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F8FD),
          ),
          padding: const EdgeInsets.all(18),
          child: Image.asset(iconPath, width: 40, height: 40),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
