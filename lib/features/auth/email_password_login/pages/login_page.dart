import 'package:luwas_travel_app/features/auth/services/auth_service.dart';
import 'package:luwas_travel_app/components/home_section.dart';
import 'package:luwas_travel_app/theme/app_text_style.dart';
import 'package:luwas_travel_app/widgets/email_text_field.dart';
import 'package:luwas_travel_app/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luwas_travel_app/widgets/forgot_password_dialog.dart';

import '../../../../widgets/custom_button.dart';
import '../../../../widgets/social_media.dart';
import 'signup_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                // Added SingleChildScrollView
                child: Column(
                  // REMOVED mainAxisAlignment: MainAxisAlignment.center
                  // REMOVED Spacers
                  children: [
                    // You can add a SizedBox here if you want some initial top padding
                    const SizedBox(height: 50), // Example: Add some space from the top

                    Text("Log In", style: AppTextStyle.bold(fontSize: 32)),
                    const SizedBox(
                        height: 30), // Increased spacing for better visual separation
                    EmailTextField(emailController: _emailController),
                    const SizedBox(
                        height: 15), // Added spacing between text fields
                    PasswordTextField(
                      passwordController: _passwordController,
                      labelText: 'Password',
                      validatorText: 'Password enter your password',
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => const ForgotPasswordDialog(),
                        ),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25), // Adjusted spacing
                    CustomButton(
                      title: 'Log In',
                      onPressed: _onLoginPressed,
                    ),
                    const SizedBox(height: 30), // Adjusted spacing
                    SocialMedia(onGooglePressed: _onGooglePressed),
                    const SizedBox(height: 30), // Adjusted spacing
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: Text(
                        "Don't have an account? Sign Up", // Clarified text
                        style: AppTextStyle.bold(fontSize: 18),
                      ),
                    ),
                    // You can add a SizedBox here if you want some bottom padding,
                    // or let the SingleChildScrollView handle the extent.
                    const SizedBox(height: 50), // Example: Add some space at the bottom
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ... (rest of your _LogInPageState code remains the same)
  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final email = _emailController.text;
      final password = _passwordController.text;

      final result = await _authService.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 1),
              content: Text(
                failure.message,
                style: AppTextStyle.regular(fontSize: 18),
              ),
            ),
          );
        },
        (user) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text('User logged in successfully'),
            ),
          );

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeSection()),
          );
        },
      );
    }
  }

  Future<void> _onGooglePressed() async {
    final result = await _authService.signInWithGoogle();

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
            content: Text(
              failure.message,
              style: AppTextStyle.regular(fontSize: 18),
            ),
          ),
        );
      },
      (user) {
        if (user == null) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
            content: Text('User logged in successfully'),
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeSection()),
        );
      },
    );
  }
}