import 'package:flutter/material.dart';
import 'package:grocery_application/pages/login_page.dart'; // Adjust the import path as necessary

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
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'We deliver your groceries to your doorstep',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: Color(0xFF000000),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          //* Fresh items everyday
          Text(
            "Fresh items everyday",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Colors.grey[800],
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),

          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ),
            child: SizedBox(
              width: 200,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(24),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      //fontSize: 24,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ]),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
