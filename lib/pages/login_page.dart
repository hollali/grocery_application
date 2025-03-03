import 'package:flutter/material.dart';
import '../assets/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //* Text editing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //* Login Function
  void login() {}

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
                'assets/images/avocado.png',
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
            ],
          )),
        ),
      )),
    );
  }
}
