import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merodoctor/presentation/pages/doctors/doctor_page.dart';
import 'package:merodoctor/presentation/pages/users/doctor_serch_page.dart';
import 'package:merodoctor/presentation/pages/inbox_page.dart';
import 'package:merodoctor/presentation/pages/more_screen.dart';
import 'package:merodoctor/presentation/pages/notification%20page.dart';
import 'package:merodoctor/presentation/pages/users/user_profile_side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    const HomeScreen(), // This is the new page content
    const DoctorListScreen(),
    const InboxPage(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  void _onCalendarPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalendarScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(0, Icons.home_outlined, 'Home'),
            _buildNavItem(1, Icons.person_outline, 'Doctors'),
            const SizedBox(width: 48.0),
            _buildNavItem(2, Icons.chat_bubble_outline, 'Messages'),
            _buildNavItem(3, Icons.grid_view, 'More'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _onCalendarPressed,
        backgroundColor: Colors.teal,
        elevation: 8.0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.calendar_today, color: Colors.white),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  color: isSelected ? Colors.teal : Colors.grey[600],
                  size: 26.0,
                ),
                const SizedBox(height: 4.0),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.teal : Colors.grey[600],
                    fontSize: 12.0,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text(
          'Calendar Details Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// --- NEW HomeScreen Widget (the requested page) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Hide default AppBar
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(context),
                const SizedBox(height: 20),

                // Banner Section
                _buildBannerSection(context),
                const SizedBox(height: 20),

                // Find Your Doctor Categories Section
                _buildCategorySection(),
                const SizedBox(height: 20),

                // Popular Doctors Section
                _buildPopularDoctorsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      children: [
        // User Avatar
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileSideBar()),
            );
          },
          child: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              'https://placehold.co/100x100/FFA500/FFFFFF?text=P',
            ), // Placeholder image
          ),
        ),
        const SizedBox(width: 12),
        // Welcome Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Welcome', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(
              'Mr. Williamson',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        // Search Icon
        IconButton(
          icon: const Icon(Icons.search, color: Colors.grey),
          onPressed: () {
            // Handle search
          },
        ),
        // Notification Icon
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade700,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Looking for\ndesired doctor?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 120, // Constrain search button width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorSearchPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Search for',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.network(
              'https://placehold.co/150x150/008080/FFFFFF?text=Doctor', // Placeholder image for doctor
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Find your doctor',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Handle See All categories
              },
              child: const Text(
                'See All >',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120, // Height for horizontal scroll view
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryItem(
                'Neurology',
                FontAwesomeIcons.brain,
                Colors.pink.shade100,
              ),
              _buildCategoryItem(
                'Cardiology',
                Icons.favorite,
                Colors.red.shade100,
              ),
              _buildCategoryItem(
                'Orthopedics',
                Icons.accessibility_new,
                Colors.blue.shade100,
              ),
              _buildCategoryItem(
                'Pathology',
                Icons.science,
                Colors.purple.shade100,
              ),
              _buildCategoryItem(
                'Dermatology',
                Icons.face,
                Colors.orange.shade100,
              ),
              _buildCategoryItem(
                'Pediatrics',
                Icons.child_care,
                Colors.green.shade100,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color bgColor) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: bgColor,
            child: Icon(icon, color: Colors.black54, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularDoctorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Doctors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Handle See All doctors
              },
              child: const Text(
                'See All >',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildDoctorCard(
          'Chloe Kelly',
          'M.Ch (Neuro)',
          '4.5 (2530)',
          '\$50.99',
          'https://placehold.co/100x100/FF69B4/FFFFFF?text=CK', // Placeholder image
        ),
        const SizedBox(height: 15),
        _buildDoctorCard(
          'Lauren Hemp',
          'Spinal Surgery',
          '4.5 (2530)',
          '\$50.99',
          'https://placehold.co/100x100/87CEEB/FFFFFF?text=LH', // Placeholder image
        ),
        // Add more doctor cards as needed
      ],
    );
  }

  Widget _buildDoctorCard(
    String name,
    String specialization,
    String rating,
    String fees,
    String imageUrl,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(radius: 40, backgroundImage: NetworkImage(imageUrl)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialization,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Fees \$${fees}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle Book Now
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
