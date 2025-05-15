import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_application/pages/login_page.dart';
import 'package:grocery_application/pages/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Short delay for better UX

    if (mounted) {
      _isCheckingAuth = false;
      if (_auth.currentUser != null) {
        // User is logged in, navigate to authentication page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthenticationPage()),
        );
      } else {
        // User is not logged in, show the splash screen with get started button
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Logo
          Padding(
            padding: const EdgeInsets.only(
                left: 80.0, right: 80, bottom: 40, top: 160),
            child: Image.asset('lib/assets/logo/logo - 1.png'),
          ),
          // We deliver groceries at your doorstep
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "We deliver groceries at your doorstep",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF2F2F2F),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // Fresh items every day
          Text(
            "Fresh items every day",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),

          if (_isCheckingAuth)
            const CircularProgressIndicator()
          else if (_auth.currentUser == null)
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
              child: SizedBox(
                width: 200,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C8E6B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
