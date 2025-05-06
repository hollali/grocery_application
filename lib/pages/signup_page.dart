import 'package:flutter/material.dart';
import 'package:grocery_application/assets/components/my_button.dart';
import 'package:grocery_application/assets/components/my_textfield.dart';
import 'package:grocery_application/assets/components/square_tile.dart';
import 'package:grocery_application/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  void _showToast(String message, bool isError) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor:
          isError ? const Color(0xFFE57373) : const Color(0xFF1C8E6B),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // sign user up method
  Future<void> signUserUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      //* validate password
      if (passwordController.text != confirmPasswordController.text) {
        throw Exception('Passwords do not match');
      }

      //* create user with email account
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //* Update user's display name
      await userCredential.user?.updateDisplayName(nameController.text);

      //* clear controllers
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      //* show success toast
      _showToast('Account created successfully', false);

      //* navigate to home page
      if (mounted) {
        Navigator.pushReplacement<dynamic, Object>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => const AuthenticationPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email already in use';
          break;
        case 'weak-password':
          errorMessage = 'Weak password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email';
          break;
        default:
          errorMessage = 'An unknown error occurred';
      }
      _showToast(errorMessage, true);
    } catch (e) {
      // Handle other exceptions
      String errorMessage = e.toString();
      _showToast(errorMessage, true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                  const SizedBox(height: 25),

                  // logo
                  Image.asset(
                    'lib/assets/logo/logo - 1.png',
                    height: 100,
                  ),

                  const SizedBox(height: 25),

                  // Create an account
                  Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // name textfield
                  MyTextField(
                    controller: nameController,
                    hintText: 'Full Name',
                    obscureText: false,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.person,
                  ),

                  const SizedBox(height: 10),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.email,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.lock,
                  ),

                  const SizedBox(height: 10),

                  // confirm password textfield
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                    prefixIcon: Icons.lock,
                  ),

                  const SizedBox(height: 25),

                  // sign up button
                  MyButton(
                    text: 'Sign Up',
                    icon: Icons.app_registration,
                    onTap: signUserUp,
                  ),

                  const SizedBox(height: 25),

                  // or continue with
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
                            'Or continue with',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // google button
                      SquareTile(imagePath: 'lib/assets/images/google.png'),

                      SizedBox(width: 15),

                      // apple button
                      SquareTile(imagePath: 'lib/assets/images/apple.png'),

                      SizedBox(width: 15),

                      // facebook button
                      SquareTile(imagePath: 'lib/assets/images/facebook.png'),

                      SizedBox(width: 15),

                      // twitter button
                      SquareTile(imagePath: 'lib/assets/images/twitter.png'),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // already have an account? login now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(width: 6),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
