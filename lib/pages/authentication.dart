import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_application/pages/dashboard.dart';
import 'package:grocery_application/pages/login_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(
        milliseconds: 100)); // short delay to ensure Firebase is ready

    if (mounted) {
      _isCheckingAuth = false;

      if (_auth.currentUser != null) {
        // if user is already logged in navigate to dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        // if user is not logged in navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (_isCheckingAuth) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // user is logged in
          if (snapshot.hasData) {
            return Dashboard();
          }
          // user is not logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}