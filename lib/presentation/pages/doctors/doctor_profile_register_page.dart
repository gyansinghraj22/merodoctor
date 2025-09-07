import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merodoctor/core/constants/app_styles.dart';
import 'package:merodoctor/data/model/create_user_model.dart';
// Assuming DoctorModel is defined in this path.
// For demonstration, I'll provide a simple DoctorModel at the end of this file.
import 'package:merodoctor/data/model/doctor_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merodoctor/domain/usecases/auth/sign_up.dart';
import 'package:merodoctor/presentation/bloc/doctor_profile_setup/doctor_profile_block.dart';
import 'package:merodoctor/presentation/bloc/doctor_profile_setup/doctor_profile_event.dart';
import 'package:merodoctor/presentation/pages/home_page.dart';
import 'package:merodoctor/service_locator.dart'; // This import should point to your actual model

class DoctorProfileSetupPage extends StatefulWidget {
  const DoctorProfileSetupPage({super.key});

  @override
  State<DoctorProfileSetupPage> createState() => _DoctorProfileSetupPageState();
}

class _DoctorProfileSetupPageState extends State<DoctorProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _qualificationsController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _profileImageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // For 'Are you Available Now', using a boolean and updating UI accordingly
  bool _isAvailable = true;
  File? _image;
  final picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialityController.dispose();
    _qualificationsController.dispose();
    _experienceController.dispose();
    _licenseNumberController.dispose();
    _profileImageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Reusable text field builder with improved styling
  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType type = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    FormFieldValidator<String>? validator, // 👈 Add this
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        decoration: kTextFormFieldDecoration.copyWith(labelText: label),
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              return null;
            },
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // final doctor = DoctorModel(
      //   doctorId:
      //       UniqueKey()
      //           .toString(), // You should replace this with Firestore ID or similar
      //   name: _nameController.text.trim(),
      //   email: _emailController.text.trim(),
      //   phone: _phoneController.text.trim(),
      //   speciality: _specialityController.text.trim(),
      //   qualifications: _qualificationsController.text.trim(),
      //   experience: int.tryParse(_experienceController.text.trim()) ?? 0,
      //   licenseNumber: _licenseNumberController.text.trim(),
      //   profileImage:      //       _profileImageController.text.trim().isEmpty
/*    //           ? null
      //           : _profileImageController.text.trim(),
      //   availability: _isAvailable,
      //   bio: _bioController.text.trim(),
      //   status: '',
      //   password: _passwordController.text.trim(),
      //   notificationToken: '',
      // );

      context.read<DoctorBloc>().add(AddDoctorEvent(doctor));

      final result = await sl<SignUpUseCase>().call(
        params: CreateUserReq(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );

      result.fold(
        (l) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.message), backgroundColor: Colors.red),
          );
        },
        (r) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (_) => false,
          );
        },
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No image selected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register As a Doctor",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey.shade50, // Light background for the page
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section for Personal Information
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(_nameController, "Full Name"),
                        _buildTextField(
                          _emailController,
                          "Official Email",
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          _phoneController,
                          "Phone Number",
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone number is required';
                            }

                            final phone = value.trim();

                            // Universal phone number regex: optional +, followed by 8 to 15 digits
                            final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

                            if (!phoneRegex.hasMatch(phone)) {
                              return 'Enter a valid phone number';
                            }

                            return null;
                          },
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _image != null
                                ? Image.file(
                                  _image!,
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                )
                                : Container(
                                  height: 130,
                                  width: 130,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    size: 100,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              icon: Icon(Icons.photo_library),
                              label: Text('Pick from Gallery'),
                              onPressed: () => _pickImage(ImageSource.gallery),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                              icon: Icon(Icons.camera_alt),
                              label: Text('Take a Photo'),
                              onPressed: () => _pickImage(ImageSource.camera),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Section for Professional Details
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Professional Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(_specialityController, "Speciality"),
                        _buildTextField(
                          _qualificationsController,
                          "Qualifications",
                        ),
                        _buildTextField(
                          _experienceController,
                          "Years of Experience",
                          type: TextInputType.number,
                        ),
                        _buildTextField(
                          _licenseNumberController,
                          "Medical License Number",
                        ),
                        _buildTextField(
                          _bioController,
                          "Bio (About Yourself)",
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),

                // Section for Availability
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Availability Status",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Are you available for consultation?",
                              style: TextStyle(fontSize: 16),
                            ),
                            Switch(
                              value: _isAvailable,
                              onChanged: (value) {
                                setState(() {
                                  _isAvailable = value;
                                });
                              },
                              activeColor: Colors.green,
                              inactiveTrackColor: Colors.red.shade200,
                              inactiveThumbColor: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  // onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Save Profile"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
