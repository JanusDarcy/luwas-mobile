import 'package:flutter/material.dart';
import 'package:luwas_travel_app/features/auth/services/auth_service.dart';
import 'package:luwas_travel_app/theme/app_text_style.dart';
import 'package:luwas_travel_app/widgets/email_text_field.dart';
import 'package:luwas_travel_app/widgets/password_text_field.dart';
import 'package:luwas_travel_app/widgets/custom_button.dart';
import 'package:luwas_travel_app/widgets/social_media.dart';
import 'package:luwas_travel_app/widgets/forgot_password_dialog.dart';
import '../../../home/home_page.dart'; // Assuming this is your actual home page after signup

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    const SizedBox(height: 50), // Example: Add some space from the top

                    Text("Sign Up", style: AppTextStyle.bold(fontSize: 32)),
                    const SizedBox(height: 30), // Increased spacing
                    EmailTextField(emailController: _emailController),
                    const SizedBox(
                        height: 15), // Added spacing between text fields
                    PasswordTextField(
                      passwordController: _passwordController,
                      labelText: 'Password',
                      validatorText: 'Password enter your password',
                    ),
                    const SizedBox(height: 10), // Maintained this small gap
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ForgotPasswordDialog(),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25), // Adjusted spacing
                    CustomButton(
                      title: 'Sign Up',
                      onPressed: _onSignUpPressed,
                    ),
                    const SizedBox(height: 30), // Adjusted spacing
                    SocialMedia(onGooglePressed: _onGooglePressed),
                    const SizedBox(height: 30), // Adjusted spacing
                    GestureDetector(
                      onTap: _onLogInPressed,
                      child: Text(
                        "Already have an account? Log In",
                        style: AppTextStyle.bold(fontSize: 18),
                      ),
                    ),
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

  // ... (rest of your _SignUpPageState code remains the same)
  Future<void> _onSignUpPressed() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final result = await _authService.signUpWithEmailAndPassword(
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
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text('User signed up successfully'),
            ),
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
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
    );
  }

  void _onLogInPressed() {
    Navigator.of(context).pop();
  }
}