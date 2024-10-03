import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  final Map data;
  const ProfileView({super.key, required this.data});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment(0, 0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                ),
                alignment: Alignment(0, 0),
                child: Text(
                  'Profil disini',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment(0, 0),
              child: Text('Fullname : ' + widget.data['fullname']),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: Text('Email : ' + widget.data['email']),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: Text('Phone Number : ' + widget.data['notelp']),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: Text('Date of Birth : ' + widget.data['tglLahir']),
            ),
          ],
        ),
      ),
    );
  }
}
