import 'package:atma_cinema/components/custom_snackbar_component.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/services/auth_service.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  final Map? data;

  const RegisterForm({super.key, this.data});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool isAgree = false;

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _notelpController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _notelpController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;
    try {
      initialDate = DateFormat("dd/MM/yyyy").parse(_tanggalController.text);
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
        _tanggalController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (!isAgree) {
        showCustomError(context, "You must agree to the terms and conditions");
        return;
      }

      final Map<String, dynamic> formData = {
        'fullName': _fullnameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _passwordConfirmController.text,
        'dateOfBirth': _tanggalController.text,
        'phoneNumber': _notelpController.text,
      };

      try {
        await AuthService().register(formData);
        CustomSnackbarComponent.showCustomSuccess(
            context, "Registration successful");
        Navigator.pop(context);
      } catch (e) {
        CustomSnackbarComponent.showCustomError(
            context, "Registration Failed, Internal Server Error");
      }
    } else {
      if (_fullnameController.text.isEmpty) {
        showCustomError(context, "Full name cannot be empty");
      } else if (_emailController.text.isEmpty) {
        showCustomError(context, "Email cannot be empty");
      } else if (!_emailController.text.contains('@') ||
          !_emailController.text.contains('.')) {
        showCustomError(context, "Enter a valid email");
      } else if (_passwordController.text.isEmpty) {
        showCustomError(context, "Password cannot be empty");
      } else if (_passwordController.text.length < 5) {
        showCustomError(context, "Password must be at least 5 characters long");
      } else if (!_passwordConfirmController.text
          .contains(_passwordController.text)) {
        showCustomError(
            context, "Reentered password does not match the password");
      } else if (_notelpController.text.isEmpty) {
        showCustomError(context, "Phone number cannot be empty");
      } else if (_tanggalController.text.isEmpty) {
        showCustomError(context, "Date of birth cannot be empty");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'empty';
                      }
                      return null;
                    },
                    controller: _fullnameController,
                    hintTxt: "full name",
                    labelTxt: "Full Name",
                  ),
                  InputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "empty";
                      }
                      if (!p0.contains('@') && !p0.contains('.')) {
                        return "Masukkan email yang valid";
                      }
                      return null;
                    },
                    controller: _emailController,
                    hintTxt: "example@gmail.com",
                    labelTxt: "Email",
                  ),
                  InputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      if (p0.length < 5) {
                        return "Password minimal 5 digit";
                      }
                      return null;
                    },
                    controller: _passwordController,
                    hintTxt: "**********",
                    iconData: Icons.visibility_off,
                    password: true,
                    labelTxt: "Password",
                  ),
                  InputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      if (p0.length < 5) {
                        return "Password minimal 5 digit";
                      }
                      if (!p0.contains(_passwordController.text)) {
                        return "Reenter password harus sama dengan password";
                      }
                      return null;
                    },
                    controller: _passwordConfirmController,
                    hintTxt: "**********",
                    iconData: Icons.visibility_off,
                    password: true,
                    labelTxt: "Reenter Password",
                  ),
                  InputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Nomor Telepon tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: _notelpController,
                    hintTxt: "+628xxxxxxxxx",
                    labelTxt: "Phone Number",
                    txtInputType: TextInputType.phone,
                  ),
                  InputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Tanggal lahir tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: _tanggalController,
                    hintTxt: "DD/MM/YYYY",
                    iconData: Icons.calendar_month,
                    labelTxt: "Date of Birth",
                    isDate: true,
                    onTap: () => _selectDate(context),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isAgree,
                            onChanged: (value) {
                              setState(() {
                                isAgree = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                                "Yes, I agree to the terms and conditions."),
                          ),
                        ],
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          foregroundColor: Colors.white,
                          minimumSize: Size(350, 48.9),
                          side: BorderSide(color: colorBorder),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          textStyle: styleBold,
                        ),
                        child: Text('Register'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          textStyle: styleMedium,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                              color: Colors.black,
                            ), // Warna teks pertama
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: colorPrimary,
                                  ),
                                ), // Warna teks Register
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomError(BuildContext context, String message,
      {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
