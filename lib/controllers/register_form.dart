import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/views/auth/login_view.dart';

class RegisterForm extends StatefulWidget {
  final Map? data;

  const RegisterForm({super.key, this.data});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool isAgree = false;

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _notelpController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _notelpController.dispose();
    _tanggalController.dispose();
    super.dispose();
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
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            if (_fullnameController.text.isEmpty) {
                              showCustomError(
                                  context, "Full name tidak boleh kosong");
                            } else if (_emailController.text.isEmpty) {
                              showCustomError(
                                  context, "Email tidak boleh kosong");
                            } else if (!_emailController.text.contains('@') ||
                                !_emailController.text.contains('.')) {
                              showCustomError(
                                  context, "Masukkan email yang valid");
                            } else if (_passwordController.text.isEmpty) {
                              showCustomError(
                                  context, "Password tidak boleh kosong");
                            } else if (_passwordController.text.length < 5) {
                              showCustomError(
                                  context, "Password minimal 5 digit");
                            } else if (!_passwordConfirmController.text
                                .contains(_passwordController.text)) {
                              showCustomError(context,
                                  "Reenter password tidak sesuai dengan password");
                            } else if (_notelpController.text.isEmpty) {
                              showCustomError(
                                  context, "Nomor telepon tidak boleh kosong");
                            } else if (_tanggalController.text.isEmpty) {
                              showCustomError(
                                  context, "Tanggal lahir tidak boleh kosong");
                            }
                          } else {
                            if (!isAgree) {
                              showCustomError(context,
                                  'You must agree to the terms and conditions');
                              return;
                            }

                            Map<String, dynamic> formData = {};

                            formData['fullname'] = _fullnameController.text;
                            formData['email'] = _emailController.text;
                            formData['password'] = _passwordController.text;
                            formData['notelp'] = _notelpController.text;
                            formData['tglLahir'] = _tanggalController.text;
                            pushLogin(context, formData);
                          }
                        },
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

  void showCustomError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void pushLogin(BuildContext context, Map<String, dynamic>? dataF) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoginView(data: dataF)),
    );
  }
}
