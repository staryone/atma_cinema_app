import 'package:atma_cinema/views/register_form.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
        title: Text('Create your Account'),
        titleTextStyle: styleMedium2,
        elevation: 0,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
