// lib/features/auth/email_password_login/pages/login_page.dart
import 'package:email_password_login/features/auth/services/auth_service.dart';
import 'package:email_password_login/components/home_section.dart';
import 'package:email_password_login/theme/app_text_style.dart';
import 'package:email_password_login/widgets/email_text_field.dart';
import 'package:email_password_login/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_password_login/widgets/forgot_password_dialog.dart';


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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log In", style: AppTextStyle.bold(fontSize: 32)),
                  const SizedBox(height: 20),
                  EmailTextField(emailController: _emailController), // Will now use blue theme
                  PasswordTextField(
                    passwordController: _passwordController,
                    labelText: 'Password',
                    validatorText: 'Password enter your password',
                  ), // Will now use blue theme
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const ForgotPasswordDialog(),
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue), // Explicitly set to blue, or could be Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Log In',
                    onPressed: _onLoginPressed,
                  ), // Will now be blue
                  const SizedBox(height: 40),
                  SocialMedia(onGooglePressed: _onGooglePressed),
                  const SizedBox(height: 80),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: AppTextStyle.bold(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

// Forgot Password Dialog (no changes needed for its appearance)
class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  String? _message;

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _message = "A password reset link has been sent to $email.";
      });
    } catch (e) {
      setState(() {
        _message = "Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Reset Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            // This TextField will also inherit the inputDecorationTheme from main.dart
            decoration: const InputDecoration(labelText: "Enter your email"),
          ),
          if (_message != null) ...[
            const SizedBox(height: 10),
            Text(
              _message!,
              style: const TextStyle(fontSize: 12, color: Colors.green),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _resetPassword,
          // ElevatedButton usually inherits theme colors, so it should be blue
          child: const Text("Send Link"),
        ),
      ],
    );
  }
}