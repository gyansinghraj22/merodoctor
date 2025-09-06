import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController(
    text: 'Gyan Singh',
  );
  final TextEditingController _lastNameController = TextEditingController(
    text: 'Rajbanshi',
  );
  final TextEditingController _ageController = TextEditingController(
    text: '24',
  );
  final TextEditingController _dobController = TextEditingController(
    text: '2001/10/14 [2058/06/28]',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'gyansinghrajbanshi1@gmail.com',
  );
  final TextEditingController _wardNo = TextEditingController(
    text: 'Enter ward No.',
  );
  bool _isRealDOB = false;
  String? _selectedGender;
  String? _selectedBloodGroup;
  String? _selectedDistrict;
  String? _selectedVDC;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  final List<String> _districts = [
    'Jhapa',
    'Morang',
    'Kathmandu',
    'Pokhara',
  ]; // Example districts
  final List<String> _vdcs = [
    'Shiva Satakxi',
    'Damak',
    'Birtamod',
    'Urlabari',
  ]; // Example VDCs

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy/MM/dd').format(picked);
        // You might want to add Bikram Sambat date conversion here if needed for [2058/06/28] part
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for the page
      appBar: AppBar(
        backgroundColor:
            Colors.teal.shade700, // Red background from previous pages
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: const NetworkImage(
                        'https://placehold.co/100x100/4285F4/FFFFFF?text=User', // Placeholder for user image
                      ),
                      onBackgroundImageError: (exception, stackTrace) {
                        // Fallback to a default icon if image fails to load
                        debugPrint('Error loading image: $exception');
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // First Name
              _buildTextField('First Name*', _firstNameController),
              const SizedBox(height: 16),

              // Last Name
              _buildTextField('Last Name*', _lastNameController),
              const SizedBox(height: 16),

              // Age
              _buildAgeField(),
              const SizedBox(height: 16),

              // Day of Birth
              _buildDobField(context),
              const SizedBox(height: 8),

              // Is real DOB checkbox
              _buildRealDobCheckbox(),
              const SizedBox(height: 16),

              // Email Address (Optional)
              _buildTextField('Email Address (Optional)', _emailController),
              const SizedBox(height: 16),

              // Gender and Blood Group
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      'Gender',
                      _selectedGender,
                      _genders,
                      (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      'Blood Group',
                      _selectedBloodGroup,
                      _bloodGroups,
                      (String? newValue) {
                        setState(() {
                          _selectedBloodGroup = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Select District and VDC/Municipality
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      'Select District',
                      _selectedDistrict,
                      _districts,
                      (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      'Select VDC/Municipality',
                      _selectedVDC,
                      _vdcs,
                      (String? newValue) {
                        setState(() {
                          _selectedVDC = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Extra space at the bottom
              Row(
                children: [
                  Expanded(child: _buildTextField("Ward No", _wardNo)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField("Tole", _wardNo)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            isDense: true, // Reduce vertical padding
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Age',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: 'Years', // Always show 'Years'
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                items:
                    <String>['Years'].map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  // This dropdown is static, so onChanged doesn't need to do anything
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDobField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Day of Birth*',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        TextFormField(
          controller: _dobController,
          readOnly: true, // Make it read-only as it's selected via date picker
          onTap: () => _selectDate(context), // Open date picker on tap
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.grey),
              onPressed: () => _selectDate(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRealDobCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isRealDOB,
          onChanged: (bool? newValue) {
            setState(() {
              _isRealDOB = newValue ?? false;
            });
          },
          activeColor: Colors.blueAccent,
        ),
        const Text(
          'Is real DOB?',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          onChanged: onChanged,
          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ],
    );
  }
}
