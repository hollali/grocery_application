import 'package:flutter/material.dart';
import 'package:grocery_application/assets/components/square_tile.dart';
import '../assets/components/my_textfield.dart';
import '../assets/components/my_button.dart'; // Add this line // Ensure correct import path
import './signup_page.dart'; // Add this line
import './forgot_password.dart'; // Add this line

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //* Text editing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //* Login Function
  void login() {}

  //* Sign User In Function
  void signUserIn() {
    // Add your sign-in logic here
  }

  //* Build Method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              //* Logo
              Image.asset(
                'lib/assets/logo/logo - 1.png',
                width: 100,
              ),
              const SizedBox(height: 50),

              //* Welcome Text
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 25),

              //* Username TextField
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
                textStyle: TextStyle(fontFamily: 'Poppins'),
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 20),

              //* Password TextField
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                textStyle: TextStyle(fontFamily: 'Poppins'),
                prefixIcon: Icons.lock,
              ),
              const SizedBox(height: 20),

              //* Forgot Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () =>Navigator.pushReplacement( 
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                    ),
                    ),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF1C8E6B),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Login',
                icon: Icons.login,
                onTap: signUserIn,
              ),
              const SizedBox(height: 25),

              //* or Continue with Google
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or Continue with',
                        style: TextStyle(
                          color: Color(0xFF1C8E6B),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Google Button
                  SquareTile(imagePath: 'lib/assets/images/google.png'),
                  SizedBox(width: 15),

                  //* apple Button
                  SquareTile(imagePath: 'lib/assets/images/apple.png'),
                  SizedBox(width: 15),

                  //* Facebook Button
                  SquareTile(imagePath: 'lib/assets/images/facebook.png'),
                  SizedBox(width: 15),

                  //* Twitter Button
                  SquareTile(imagePath: 'lib/assets/images/twitter.png'),
                  SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 25),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Don\'t have account?',
                  style: TextStyle(
                    color: Color(0xFF1C8E6B),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () =>Navigator.pushReplacement( 
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                  ),
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Color(0xFF1C8E6B),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
              ]),
            ],
          )),
        ),
      )),
    );
  }
}
