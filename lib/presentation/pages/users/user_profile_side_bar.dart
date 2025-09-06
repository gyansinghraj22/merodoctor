import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merodoctor/presentation/pages/appointment_page.dart';
import 'package:merodoctor/presentation/pages/doctors/doctor_profile_register_page.dart';
import 'package:merodoctor/presentation/pages/users/edit_profile.dart'; // For some specific icons if needed, though mostly Material Icons are used here.

// Placeholder for other pages if they were imported in the original context
class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prescription')),
      body: const Center(child: Text('Prescription Details')),
    );
  }
}

class MedicalRecordPage extends StatelessWidget {
  const MedicalRecordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical Record')),
      body: const Center(child: Text('Medical Record Details')),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(child: Text('Favorites Details')),
    );
  }
}

class LabServicesPage extends StatelessWidget {
  const LabServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Services')),
      body: const Center(child: Text('Lab Services Details')),
    );
  }
}

class LabOrderPage extends StatelessWidget {
  const LabOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Order')),
      body: const Center(child: Text('Lab Order Details')),
    );
  }
}

class DependentsPage extends StatelessWidget {
  const DependentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dependents')),
      body: const Center(child: Text('Dependents Details')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Details')),
    );
  }
}

class UserProfileSideBar extends StatefulWidget {
  const UserProfileSideBar({super.key});

  @override
  State<UserProfileSideBar> createState() => _UserProfileSideBarState();
}

class _UserProfileSideBarState extends State<UserProfileSideBar>
    with TickerProviderStateMixin {
  // Using TickerProviderStateMixin because there might be multiple AnimationControllers
  // or potential for more in a complex profile page.

  late AnimationController _headerFadeController;
  late Animation<double> _headerFadeAnimation;

  late AnimationController _cardSlideController;
  late Animation<Offset> _cardSlideAnimation;

  late AnimationController _listFadeController;
  late Animation<double> _listFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Header fade-in animation
    _headerFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerFadeController, curve: Curves.easeOut),
    );

    // Cards slide-in animation
    _cardSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _cardSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2), // Starts slightly below
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _cardSlideController, curve: Curves.easeOutCubic),
    );

    // List items fade-in animation
    _listFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _listFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _listFadeController, curve: Curves.easeIn),
    );

    // Start animations in sequence
    _headerFadeController.forward();
    _cardSlideController.forward();
    _listFadeController.forward();
  }

  @override
  void dispose() {
    _headerFadeController.dispose();
    _cardSlideController.dispose();
    _listFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for the main body
      body: CustomScrollView(
        slivers: [
          // Custom AppBar/Header Section
          SliverAppBar(
            expandedHeight: 220.0, // Height of the expanded header
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.teal.shade700, // Red color from the image
                child: FadeTransition(
                  opacity: _headerFadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20), // For status bar padding
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              // Handle edit profile
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Edit Profile Tapped!'),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white, // White border
                        child: ClipOval(
                          child: Image.network(
                            'https://placehold.co/100x100/4285F4/FFFFFF?text=User', // Placeholder for user image
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.blueAccent,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          const Text(
                            'Gyan Singh Rajbanshi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DoctorProfileSetupPage(),
                                ),
                              );
                            },
                            child: const Text("Set Up as Doctor Profile"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main content below the header
          SliverList(
            delegate: SliverChildListDelegate([
              // Grid of Cards
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SlideTransition(
                  position: _cardSlideAnimation,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildFeatureCard(
                            context,
                            'Prescription',
                            Icons.description_outlined,
                            const Color(0xFF4CAF50), // Green
                            const PrescriptionPage(),
                          ),
                          const SizedBox(width: 16),
                          _buildFeatureCard(
                            context,
                            'Medical Record',
                            Icons.medical_services_outlined,
                            const Color(0xFF2196F3), // Blue
                            const MedicalRecordPage(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildFeatureCard(
                            context,
                            'Appointment',
                            Icons.favorite_border,
                            const Color(0xFFE91E63), // Pink/Red
                            const AppointmentPage(),
                          ),
                          const SizedBox(width: 16),
                          _buildFeatureCard(
                            context,
                            'Favourites',
                            Icons.star_border,
                            const Color(0xFF9C27B0), // Purple
                            const FavoritesPage(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // List of Menu Items
              FadeTransition(
                opacity: _listFadeAnimation,
                child: Column(
                  children: [
                    _buildMenuItem(
                      context,
                      'Lab Services',
                      FontAwesomeIcons
                          .users, // Using FontAwesome for the group icon
                      const LabServicesPage(),
                    ),
                    _buildMenuItem(
                      context,
                      'Lab Order',
                      FontAwesomeIcons.users, // Same icon
                      const LabOrderPage(),
                    ),
                    _buildMenuItem(
                      context,
                      'Dependents',
                      FontAwesomeIcons.users, // Same icon
                      const DependentsPage(),
                    ),
                    _buildMenuItem(
                      context,
                      'Settings',
                      Icons.settings_outlined,
                      const SettingsPage(),
                    ),
                    _buildMenuItem(
                      context,
                      'Sign Out',
                      Icons.logout, // Logout icon
                      null, // No navigation for sign out, just an action
                      isSignOut: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // Extra space at the bottom
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return Expanded(
      child: Card(
        color: color,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 30),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.7),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget? page, {
    bool isSignOut = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: isSignOut ? Colors.red : Colors.grey[700],
            size: 28,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSignOut ? Colors.red : Colors.black87,
            ),
          ),
          trailing:
              isSignOut
                  ? null // No trailing icon for Sign Out
                  : Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 18,
                  ),
          onTap: () {
            if (isSignOut) {
              // Handle sign out logic
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Signing out...')));
              // Example: Navigator.pop(context); // Go back to login screen
            } else if (page != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          },
        ),
        if (!isSignOut)
          const Divider(
            height: 1,
            indent: 72, // Aligns with the text, past the icon
            endIndent: 16,
            color: Colors.grey,
          ),
      ],
    );
  }
}
