import 'dart:io';

import 'package:atma_cinema/clients/user_client.dart';
import 'package:atma_cinema/components/custom_snackbar_component.dart';
import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/providers/user_provider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/utils/date_utils.dart';
import 'package:atma_cinema/views/profile/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileView extends ConsumerStatefulWidget {
  final UserModel data;
  const EditProfileView({super.key, required this.data});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _gender;
  String? _imagePath;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _emailController.text = widget.data.email;
    _nameController.text = widget.data.fullName;
    _dobController.text = formatDate(widget.data.dateOfBirth);
    _phoneController.text = widget.data.phoneNumber;
    _gender = widget.data.gender;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    ref.invalidate(userFetchDataProvider);
  }

  Future<void> _openCamera() async {
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CameraView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _imagePath = result;
      });
    }
  }

  Future<void> _openLibrary() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;
    try {
      initialDate = DateFormat("dd/MM/yyyy").parse(_dobController.text);
    } catch (e) {
      initialDate = DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
      });
    }
  }

  void _showProfilePictureOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Profile Picture",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.blue[900]),
                title: Text("Choose from library"),
                onTap: () {
                  Navigator.pop(context);
                  _openLibrary();
                },
              ),
              ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.blue[900]),
                  title: Text("Take photo"),
                  onTap: () {
                    Navigator.pop(context);
                    _openCamera();
                  }),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text(
                  "Remove current picture",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateProfile() async {
    Map<String, dynamic> data = {
      'fullName': _nameController.text,
      'email': _emailController.text,
      'dateOfBirth': _dobController.text,
      'gender': _gender,
      'phoneNumber': _phoneController.text,
    };

    if (_imagePath != null) {
      data['profilePicture'] = File(_imagePath!);
    }

    setState(() {
      _isLoading = true;
    });

    final userClient = UserClient();

    try {
      print(await userClient.updateProfile(data));

      CustomSnackbarComponent.showCustomSuccess(context, "Update successful");
    } catch (e) {
      CustomSnackbarComponent.showCustomError(context, "Update failed: $e");
    } finally {
      setState(() {
        _isLoading = false;
        _refreshData();
      });
    }
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Personal Information"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showProfilePictureOptions,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: (_imagePath != null)
                            ? FileImage(File(_imagePath!))
                            : (widget.data.profilePicture != null)
                                ? NetworkImage(widget.data.profilePicture!)
                                : null,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey.withOpacity(0.5),
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Profile Picture',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Use a high resolution square image of up to 1MB',
                      style:
                          GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InputForm(
                validasi: _validateRequired,
                controller: _nameController,
                hintTxt: 'Enter your full name',
                labelTxt: 'Full Name *',
              ),
              InputForm(
                validasi: _validateRequired,
                controller: _dobController,
                hintTxt: 'Select your date of birth',
                labelTxt: 'Date of Birth *',
                isDate: true,
                onTap: () => _selectDate(context),
                iconData: Icons.calendar_today,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 0.0),
                    child: Text(
                      "Gender",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildRadioButton("Male"),
                      const SizedBox(width: 20),
                      _buildRadioButton("Female"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InputForm(
                validasi: _validateRequired,
                controller: _emailController,
                hintTxt: 'Enter your email',
                labelTxt: 'Email *',
                iconData: Icons.check_circle,
              ),
              InputForm(
                validasi: (value) => null,
                controller: _phoneController,
                hintTxt: 'Enter your phone number',
                labelTxt: 'Phone Number',
              ),
              const SizedBox(height: 10),
              Text(
                "*Indicates required field",
                style: GoogleFonts.roboto(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _updateProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    // primary: const Color(0xFF0D47A1),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: _gender,
          onChanged: (value) {
            setState(() {
              _gender = value;
            });
          },
          activeColor: colorPrimary,
        ),
        Text(
          gender,
          style: GoogleFonts.roboto(fontSize: 16),
        ),
      ],
    );
  }
}
