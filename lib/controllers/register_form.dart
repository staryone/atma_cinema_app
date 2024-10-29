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

  @override
  Widget build(BuildContext context) {
    TextEditingController fullnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController notelpController = TextEditingController();
    TextEditingController tanggalController = TextEditingController();

    return Container(
      alignment: Alignment.center,
      // height: MediaQuery.of(context).size.height,
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
                  controller: fullnameController,
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
                  controller: emailController,
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
                  controller: passwordController,
                  hintTxt: "**********",
                  iconData: Icons.visibility_off,
                  password: true,
                  labelTxt: "Password",
                ),
                InputForm(
                  validasi: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Nomor Telepon tidak boleh kosong";
                    }
                    return null;
                  },
                  controller: notelpController,
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
                  controller: tanggalController,
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
                          child:
                              Text("Yes, I agree to the terms and conditions."),
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
                          if (fullnameController.text.isEmpty) {
                            showCustomError(
                                context, "Full name tidak boleh kosong");
                          } else if (emailController.text.isEmpty) {
                            showCustomError(
                                context, "Email tidak boleh kosong");
                          } else if (!emailController.text.contains('@') ||
                              !emailController.text.contains('.')) {
                            showCustomError(
                                context, "Masukkan email yang valid");
                          } else if (passwordController.text.isEmpty) {
                            showCustomError(
                                context, "Password tidak boleh kosong");
                          } else if (passwordController.text.length < 5) {
                            showCustomError(
                                context, "Password minimal 5 digit");
                          } else if (notelpController.text.isEmpty) {
                            showCustomError(
                                context, "Nomor telepon tidak boleh kosong");
                          } else if (tanggalController.text.isEmpty) {
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

                          formData['fullname'] = fullnameController.text;
                          formData['email'] = emailController.text;
                          formData['password'] = passwordController.text;
                          formData['notelp'] = notelpController.text;
                          formData['tglLahir'] = tanggalController.text;
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
                    )
                  ],
                )
              ],
            ),
          ),
        ],
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
