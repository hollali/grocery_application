import 'package:flutter/material.dart';
import 'package:grocery_application/assets/components/my_button.dart';
import 'package:grocery_application/assets/components/my_textfield.dart';
import 'package:grocery_application/assets/components/square_tile.dart';
import 'package:grocery_application/pages/forgot_password.dart';
import 'package:grocery_application/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_application/pages/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ---- text editing controller ----
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  void _showToast(String message, bool isError) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor:
          isError ? const Color(0xFFE57373) : const Color(0xFF1C8E6B),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  Future<void> signUserIn() async {
    setState(() => _isLoading = true);

    try {
      // Trim input values
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Basic validation before making Firebase call
      if (email.isEmpty) {
        _showToast('Please enter your email', true);
        return;
      }
      if (password.isEmpty) {
        _showToast('Please enter your password', true);
        return;
      }

      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Clear controllers
      emailController.clear();
      passwordController.clear();

      _showToast('Login successful!', false);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      print('Firebase error code: ${e.code}'); // Debug print
      print('Firebase error message: ${e.message}'); // Debug print

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted';
          break;
        case 'user-disabled':
          errorMessage =
              'This account has been disabled. Please contact support';
          break;
        case 'user-not-found':
          errorMessage =
              'No account found with this email. Please check or register';
          break;
        case 'wrong-password':
        case 'invalid-credential': // Adding this to cover more cases
          errorMessage = 'Incorrect password. Please try again';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your connection';
          break;
        default:
          errorMessage = 'Login failed: The supplied credentials are incorrect';
      }
      _showToast(errorMessage, true);
    } catch (e) {
      print('General error: $e'); // Debug print
      _showToast('An unexpected error occurred. Please try again', true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),

                      // ---- app logo ----
                      Image.asset(
                        'lib/assets/logo/logo - 1.png',
                        height: 100,
                      ),

                      const SizedBox(height: 50),

                      // ---- welcome text ----
                      Text(
                        'Welcome back you\'ve been missed!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 25),

                      // ---- email text field ----
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        textStyle: const TextStyle(fontFamily: 'Poppins'),
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 25),

                      // ---- password text field ----
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        textStyle: const TextStyle(fontFamily: 'Poppins'),
                        prefixIcon: Icons.lock,
                      ),
                      const SizedBox(height: 10),

                      // ---- forget password ----
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage()),
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: const Color(0xFF1C8E6B),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // ---- login button ----
                      MyButton(
                        text: 'Login',
                        icon: Icons.login,
                        onTap: signUserIn,
                      ),
                      const SizedBox(height: 25),

                      // ---- or continue with ----
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(
                                  color: const Color(0xFF1C8E6B),
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
                      // ----- social media buttons -----
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google
                          SquareTile(imagePath: 'lib/assets/images/google.png'),
                          const SizedBox(width: 15),

                          // ---- apple ----
                          SquareTile(imagePath: 'lib/assets/images/apple.png'),
                          const SizedBox(width: 15),

                          // ---- facebook ----
                          SquareTile(
                              imagePath: 'lib/assets/images/facebook.png'),
                          const SizedBox(width: 15),

                          // ---- twitter ----
                          SquareTile(
                              imagePath: 'lib/assets/images/twitter.png'),
                        ],
                      ),
                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            ),
                            child: Text(
                              'Register now',
                              style: TextStyle(
                                color: const Color(0xFF1C8E6B),
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1C8E6B)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
