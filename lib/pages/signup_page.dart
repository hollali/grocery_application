import 'package:flutter/material.dart';
import 'package:grocery_application/assets/components/my_button.dart';
import 'package:grocery_application/assets/components/my_textfield.dart';
import 'package:grocery_application/assets/components/square_tile.dart';
import 'package:grocery_application/pages/login_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //* text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //* sign up function
  void signUserUp() {
    // sign up logic here
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25,),

                  //* Logo
                  Image.asset('lib/assets/logo/logo - 1.png',
                  height: 100,
                  ),
                  const SizedBox(height: 25,),

                  //* Create an Account
                  Text('Create an Account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  ),

                  const SizedBox(height: 25,),

                  //* name text field
                  MyTextField(
                    controller: nameController,
                    hintText: 'Enter your name',
                    obscureText: false,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 10,),

                  //* email text field
                  MyTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    obscureText: false,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 10,),

                  //* password text field
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscureText: true,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.lock,
                  ),
                  const SizedBox(height: 10,),

                  
                ],
              ),
            ),),
        )),
      );
  }
}
