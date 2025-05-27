// lib/widgets/email_text_field.dart
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
  final String labelText;
  final String? validatorText;

  const EmailTextField({
    super.key,
    required this.emailController,
    this.labelText = 'Email',
    this.validatorText = 'Please enter your email',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      // REMOVED explicit InputDecoration styling for border and label color.
      // These will now be inherited from ThemeData's inputDecorationTheme in main.dart.
      decoration: InputDecoration(
        labelText: labelText,
        // If you need an icon, add it here:
        // prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }
}