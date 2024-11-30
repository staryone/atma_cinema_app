import 'package:atma_cinema/clients/user_client.dart';
import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/views/dashboard_view.dart';
import 'package:atma_cinema/views/auth/register_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginForm extends StatefulWidget {
  final UserModel? data;

  const LoginForm({super.key, this.data});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception("Login dibatalkan");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final authService = AuthService();
      final loginData = {
        'email': googleUser.email,
        'name': googleUser.displayName,
        'profilePicture': googleUser.photoUrl,
      };
      // print(loginData);

      await authService.loginWithGoogle(loginData);

      if (await authService.isLoggedIn()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login with Google successful")),
        );

        final userClient = UserClient();
        final userData = await userClient.getProfile();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardView(data: userData),
          ),
        );
      } else {
        showCustomError(
            context, "Login failed: Invalid response from internal server");
      }
    } catch (e) {
      showCustomError(context, "Login with Google failed: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      if (_emailController.text.isEmpty) {
        showCustomError(context, "Email tidak boleh kosong");
      } else if (!_emailController.text.contains('@') ||
          !_emailController.text.contains('.')) {
        showCustomError(context, "Masukkan email yang valid");
      } else if (_passwordController.text.isEmpty) {
        showCustomError(context, "Password tidak boleh kosong");
      } else if (_passwordController.text.length < 5) {
        showCustomError(context, "Password minimal 5 digit");
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    final loginData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    try {
      await authService.login(loginData);

      if (await authService.isLoggedIn()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );

        final userClient = UserClient();
        final userData = await userClient.getProfile();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardView(data: userData),
          ),
        );
      } else {
        showCustomError(context, "Login failed: Invalid response from server");
      }
    } catch (e) {
      showCustomError(context, "Login failed: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
          child: Column(
            children: [
              SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _loginWithGoogle,
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
                    InputForm(
                      validasi: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Email tidak boleh kosong";
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _login,
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
        ),
        if (_isLoading)
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
      ],
    );
  }

  void showCustomError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
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
