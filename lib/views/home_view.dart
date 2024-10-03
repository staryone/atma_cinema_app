import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/login_view.dart';
import 'package:atma_cinema/views/profile_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfileView(),
                ),
              ),
              icon: const Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LoginView(),
                ),
              ),
              icon: const Icon(Icons.notifications),
            ),
          ],
        ),
        body: Center(
          child: Text('Ini home'),
        ),
      ),
    );
  }
}
