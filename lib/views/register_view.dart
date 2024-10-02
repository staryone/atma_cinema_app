import 'package:flutter/material.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayText(text: "Full Name"),
                inputForm(
                  (p0){
                    if(p0==null || p0.isEmpty){
                      return "Full name tidak boleh kosong";
                    }
                    return null;
                  },
                  controller: fullnameController, 
                  hintTxt: "full name", 
                ),
                displayText(text: "Email"),
                inputForm(
                  (p0){
                    if(p0==null || p0.isEmpty){
                      return "Email tidak boleh kosong";
                    }
                    if(!p0.contains('@') && !p0.contains('.')){
                      return "Masukkan email yang valid";
                    }
                    return null;
                  },
                  controller: emailController, 
                  hintTxt: "example@gmail.com", 
                ),
                displayText(text: "Password"),
                inputForm(
                  (p0){
                    if(p0==null || p0.isEmpty){
                      return "Password tidak boleh kosong";
                    }
                    if(p0.length<5){
                      return "Password minimal 5 digit";
                    }
                    return null;
                  },
                  controller: passwordController, 
                  hintTxt: "**********",
                  iconData: Icons.remove_red_eye_outlined, 
                  password: true
                ),
                displayText(text: "Phone Number"),
                inputForm(
                  (p0){
                    if(p0==null || p0.isEmpty){
                      return "Nomor Telepon tidak boleh kosong";
                    }
                    return null;
                  },
                  controller: notelpController, 
                  hintTxt: "+628xxxxxxxxx", 
                ),
                displayText(text: "Date of Birth"),
                inputForm(
                  (p0){
                    if(p0==null || p0.isEmpty){
                      return "Tanggal lahir tidak boleh kosong";
                    }
                    return null;
                  },
                  controller: tanggalController, 
                  hintTxt: "DD/MM/YYYY",
                  iconData: Icons.calendar_month, 
                ),
                ElevatedButton(
                  onPressed: (){
                    Map<String, dynamic> formData = {};
                    formData['username'] = fullnameController.text;
                    formData['password'] = passwordController.text;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData,)));
                  },
                  child: const Text("Register"),
                ),
                // Row(
                  
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     TextButton(
                //       onPressed: () {},
                //       child: const Text(' '),
                //     ),
                //     TextButton(
                //       onPressed: () {},
                //       child: const Text(' '),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}