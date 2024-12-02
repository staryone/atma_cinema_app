import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/providers/user_provider.dart';
import 'package:atma_cinema/services/auth_service.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/auth/login_view.dart';
import 'package:atma_cinema/views/profile/about_view.dart';
import 'package:atma_cinema/views/profile/change_password_view.dart';
import 'package:atma_cinema/views/profile/editprofile_view.dart';
import 'package:atma_cinema/views/profile/help_center_view.dart';
import 'package:atma_cinema/views/profile/privacy_view.dart';
import 'package:atma_cinema/views/profile/terms_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  Future<void> _logout() async {
    final authService = AuthService();
    try {
      await authService.logout();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logout successful")),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userFetchDataProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Account"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: colorPrimary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Atma Cinema",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      MenuItem(
                        icon: Icons.help_outline,
                        text: "Help Center",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpCenterView(),
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        icon: Icons.info_outline,
                        text: "About Us",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutView(),
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        icon: Icons.description_outlined,
                        text: "Terms and Conditions",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsView(),
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        icon: Icons.privacy_tip_outlined,
                        text: "Privacy Policy",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyView(),
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        icon: Icons.lock_outline,
                        text: "Change Password",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordView(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: _logout,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Follow us on:",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.abc),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.facebook),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              elevation: 2,
              child: userAsyncValue.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                    ),
                    title: Text("Undefined"),
                    subtitle: const Text("See Profile"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ),
                data: (user) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (user.profilePicture != null)
                        ? NetworkImage(user.profilePicture!)
                        : null,
                    radius: 24,
                  ),
                  title: Text(user.fullName),
                  subtitle: const Text("See Profile"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EditProfileView(
                          data: user,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
