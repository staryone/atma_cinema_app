import 'package:atma_cinema/clients/user_client.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _isOldPasswordValid = true;
  bool _isNewPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isLoading = false;
  final UserClient _userClient = UserClient();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width - 32,
              padding:
                  const EdgeInsets.symmetric(vertical: 90.0, horizontal: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Your password has been changed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  SvgPicture.asset(
                    'images/family_star.svg',
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Press Anywhere to Close',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      _showError("New password and confirmation password do not match.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await _userClient.changePassword({
        "currentPassword": oldPassword,
        "newPassword": newPassword,
        "newPassword_confirmation": confirmPassword,
      });

      if (response["message"] == "Password changed successfully") {
        _showSuccessDialog();
      } else {
        _showError(response["message"] ?? "Failed to change password.");
      }
    } catch (e) {
      _showError("An error occurred: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // void _showSuccessDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Success"),
  //         content: const Text("Your password has been changed."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.of(context).pop(); // Close the Change Password screen
  //             },
  //             child: const Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void toggleOldPasswordVisibility() {
    setState(() {
      _isOldPasswordVisible = !_isOldPasswordVisible;
    });
  }

  void toggleNewPasswordVisibility() {
    setState(() {
      _isNewPasswordVisible = !_isNewPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void showCustomError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: InputForm(
                    validasi: (value) {
                      return _isOldPasswordValid
                          ? null
                          : 'This field is required';
                    },
                    controller: _oldPasswordController,
                    hintTxt: "**********",
                    labelTxt: 'Old Password',
                    password: true,
                    onToggleVisibility: toggleOldPasswordVisibility,
                    borderColor: _isOldPasswordValid ? null : Colors.red,
                    width: 400,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: InputForm(
                    validasi: (value) {
                      return _isNewPasswordValid
                          ? null
                          : 'This field is required';
                    },
                    controller: _newPasswordController,
                    hintTxt: "**********",
                    labelTxt: 'New Password',
                    password: true,
                    onToggleVisibility: toggleNewPasswordVisibility,
                    borderColor: _isNewPasswordValid ? null : Colors.red,
                    width: 400,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: InputForm(
                    validasi: (value) {
                      return _isConfirmPasswordValid
                          ? null
                          : 'This field is required';
                    },
                    controller: _confirmPasswordController,
                    hintTxt: "**********",
                    labelTxt: 'Re-enter New Password',
                    password: true,
                    onToggleVisibility: toggleConfirmPasswordVisibility,
                    borderColor: _isConfirmPasswordValid ? null : Colors.red,
                    width: 400,
                  ),
                ),
              ),
              const SizedBox(height: 150),
              Center(
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
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
}
