import 'package:flutter/material.dart';
import 'package:grocery_application/assets/components/my_button.dart';
import 'package:grocery_application/assets/components/my_textfield.dart';
import 'package:grocery_application/pages/login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  // text editing controller
  final emailController = TextEditingController();

  // reset password method
  void resetPassword() {
    // Add reset password logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1C8E6B)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),

                  // logo
                  Image.asset(
                    'lib/assets/logo/logo - 1.png',
                    height: 100,
                  ),

                  const SizedBox(height: 25),

                  // Reset Password text
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Reset instruction text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Enter your email and we will send you a password reset link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.email,
                  ),

                  const SizedBox(height: 25),

                  // reset password button
                  MyButton(
                    text: 'Send Reset Link',
                    icon: Icons.mail_outline,
                    onTap: resetPassword,
                  ),

                  const SizedBox(height: 25),

                  // back to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remember your password?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ),
                        child: Text(
                          'Login now',
                          style: TextStyle(
                            color: Color(0xFF1C8E6B),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}