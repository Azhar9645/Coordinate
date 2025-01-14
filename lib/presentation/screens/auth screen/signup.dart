import 'package:coordinate_app/presentation/screens/auth%20screen/signIn.dart';
import 'package:coordinate_app/presentation/widget/main_button.dart';
import 'package:coordinate_app/presentation/widget/textfield.dart';
import 'package:coordinate_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        // Create user with email and password
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // After successful signup, navigate to SignInScreen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully!')),
        );

        // Navigate to the SignInScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => SignInScreen()),
        );
      }
    } catch (e) {
      // Show error if sign up fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fill Your Profile',
          style: j24.copyWith(fontSize: 24), // Remove ScreenUtil
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.all(18), // Remove ScreenUtil
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Remove ScreenUtil
                Text(
                  'Welcome!',
                  style: j20.copyWith(fontSize: 20), // Remove ScreenUtil
                ),
                SizedBox(height: 10), // Remove ScreenUtil
                Text(
                  'Please create your account here',
                  style: jStyleW.copyWith(fontSize: 16), // Remove ScreenUtil
                ),
                SizedBox(height: 50), // Remove ScreenUtil
                MyTextfield(
                  controller: nameController,
                  hintText: 'First Name',
                  prefixIcon: const Icon(Icons.person_2_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }

                    if (value.length < 5) {
                      return 'First name must be at least 5 characters';
                    }

                    return null;
                  },
                  maxline: 1,
                ),
                SizedBox(height: 20), // Remove ScreenUtil
                MyTextfield(
                  controller: emailController,
                  hintText: 'abc@email.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }

                    return null;
                  },
                  maxline: 1,
                ),
                SizedBox(height: 20), // Remove ScreenUtil
                MyTextfield(
                  controller: phoneController,
                  hintText: 'Enter your phone number',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                  maxline: 1,
                ),
                SizedBox(height: 20), // Remove ScreenUtil
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[^\w]'))) {
                      return 'Password must contain at least one non-alphabetic character';
                    }
                    return null;
                  },
                  maxline: 1,
                ),
                SizedBox(height: 20), // Remove ScreenUtil
                MyTextfield(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  maxline: 1,
                ),
                SizedBox(height: 20), // Remove ScreenUtil
                MyButton(
                  text: 'Confirm',
                  onPressed: () {
                    _signUp(context); // Call sign-up function
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
