import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/views/dashboard_view.dart';
import 'package:atma_cinema/views/register_view.dart';

class LoginForm extends StatefulWidget {
  final Map? data;

  const LoginForm({super.key, this.data});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Container(
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
        children: [
          SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: () {},
            icon: SvgPicture.asset('images/googleIcon.svg'),
            label: Text("Login with Google"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: colorPrimary,
              minimumSize: Size(350, 48.9),
              side: BorderSide(color: colorBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              textStyle: GoogleFonts.roboto(
                textStyle: styleBold,
              ),
            ),
          ),
          const SizedBox(height: 21.5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(color: colorBorder, thickness: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("or"),
                ),
                Expanded(
                  child: Divider(color: colorBorder, thickness: 1),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                inputForm(
                  (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Email tidak boleh kosong";
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
                inputForm(
                  (p0) {
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => const DashboardView(),
                          //   ),
                          // );
                          if (dataForm != null &&
                              dataForm['email'] == emailController.text &&
                              dataForm['password'] == passwordController.text) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DashboardView(),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Password Salah!'),
                                content: TextButton(
                                  onPressed: () => pushRegister(context),
                                  child: const Text('Daftar Disini !!'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
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
                      child: Text('Login'),
                    ),
                    SizedBox(height: 75),
                    TextButton(
                      onPressed: () {
                        // Map<String, dynamic> formData = {};
                        // formData['email'] = emailController.text;
                        // formData['password'] = passwordController.text;
                        pushRegister(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: styleMedium,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: colorPrimary,
                                ),
                              ),
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

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterView()),
    );
  }
}
