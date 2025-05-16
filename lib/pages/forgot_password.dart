import 'package:flutter/material.dart';
import 'package:grocery_application/assets/components/my_button.dart';
import 'package:grocery_application/assets/components/my_textfield.dart';
import 'package:grocery_application/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // text editing controller
  final emailController = TextEditingController();
  bool _isLoading = false;

  void _showToast(String message, bool isError) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: isError ? const Color(0xFFE57373) : const Color(0xFF1C8E6B),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // reset password method
  Future<void> resetPassword() async {
    setState(() => _isLoading = true);
    
    try {
      final email = emailController.text.trim();
      
      // Validate email
      if (email.isEmpty) {
        _showToast('Please enter your email', true);
        return;
      }
      
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      
      _showToast('Password reset link sent to your email', false);
      emailController.clear();
      
      // Optionally navigate back to login after a short delay
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted';
          break;
        case 'user-not-found':
          errorMessage = 'No account found with this email';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later';
          break;
        default:
          errorMessage = 'Failed to send reset link. Please try again';
      }
      _showToast(errorMessage, true);
    } catch (e) {
      _showToast('An unexpected error occurred', true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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