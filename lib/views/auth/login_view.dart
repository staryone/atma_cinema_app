import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/components/appbar_component.dart';
import 'package:atma_cinema/controllers/login_form.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;

    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: GradientAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'images/backgroudAppBar.jpeg',
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top - 15,
                    left: 25,
                    child: Text(
                      "Welcome, again Atmares!",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              LoginForm(data: dataForm),
            ],
          ),
        ),
      ),
    );
  }
}
