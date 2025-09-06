import 'package:flutter/material.dart';

class DoctorSearchPage extends StatelessWidget {
  const DoctorSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Looking for desired doctor?'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            const SizedBox(height: 24),
            _buildSectionHeader('Find your doctor', 'See All'),
            const SizedBox(height: 16),
            _buildSpecialtyGrid(),
            const SizedBox(height: 24),
            _buildSectionHeader('Popular Doctors', 'See All'),
            const SizedBox(height: 16),
            _buildDoctorList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          actionText,
          style: TextStyle(
            color: Colors.blue[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialtyGrid() {
    final specialties = [
      {'name': 'Neurology', 'selected': false},
      {'name': 'Cardiology', 'selected': true},
      {'name': 'Orthopedics', 'selected': false},
      {'name': 'Pathology', 'selected': false},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children:
          specialties.map((specialty) {
            return Container(
              decoration: BoxDecoration(
                color:
                    specialty['selected'] as bool
                        ? Colors.blue[50]
                        : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      specialty['selected'] as bool
                          ? Colors.blue
                          : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  specialty['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color:
                        specialty['selected'] as bool
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildDoctorList() {
    final doctors = [
      {
        'name': 'Chloe Kelly',
        'specialty': 'M.Ch (Neuro)',
        'rating': '4.5 (2530)',
        'fees': '\$50.99',
      },
      {
        'name': 'Lauren Hemp',
        'specialty': 'Spinal Surgery',
        'rating': '4.5 (2530)',
        'fees': '\$50.99',
      },
    ];

    return Column(
      children:
          doctors.map((doctor) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/doctor1.jpg'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor['name'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                doctor['specialty'] as String,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(doctor['rating'] as String),
                        const Spacer(),
                        Text(
                          'Fees ${doctor['fees']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
