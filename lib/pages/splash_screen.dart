import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //* App Logo
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              right: 80,
              bottom: 40.0,
              top: 160,
            ),
            child: Image.asset('lib/assets/logo/logo - 1.png'),
          ),
        ],
      ),
    );
  }
}
