import 'package:coordinate_app/presentation/screens/home/interest_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coordinate_app/presentation/screens/auth%20screen/signup.dart';
import 'package:coordinate_app/presentation/widget/custom_snackbar.dart';
import 'package:coordinate_app/presentation/widget/main_button.dart';
import 'package:coordinate_app/presentation/widget/textfield.dart';
import 'package:coordinate_app/utils/constants.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      // Authenticate user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the home screen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InterestScreen(), // Replace with your HomeScreen widget
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors
      String errorMessage = 'Something went wrong. Please try again.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Invalid password.';
      }
      customSnackbar(context, errorMessage, kRed, Icons.error);
    } catch (e) {
      // Handle any other errors
      customSnackbar(context, 'Unexpected error: $e', kRed, Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Getting Started!',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MyTextfield(
                    controller: emailController,
                    hintText: 'abc@email.com',
                    prefixIcon: Icon(Icons.email_outlined, size: 24.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      ).hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  MyTextfield(
                    controller: passwordController,
                    hintText: 'Your password',
                    obscureText: true,
                    maxline: 1,
                    prefixIcon: Icon(Icons.lock_outline, size: 24.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle Forgot Password logic
                        },
                        child: const Text('Forgot password?',
                            style: TextStyle(color: kGreen)),
                      ),
                    ],
                  ),
                  MyButton(
                    text: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signIn(context);
                      } else {
                        customSnackbar(context, 'Fill All Fields', kRed,
                            Icons.warning);
                      }
                    },
                  ),
                  SizedBox(height: 30.0),
                  Text('Or Continue with',
                      style: TextStyle(fontSize: 14.0)),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Handle Google sign-in logic here
                    },
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/google.png',
                          width: 55.0,
                          height: 55.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have any account?',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: kGreen,
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
