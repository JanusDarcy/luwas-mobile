// lib/widgets/password_text_field.dart
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;
  final String labelText;
  final String validatorText;

  const PasswordTextField({
    super.key,
    required this.passwordController,
    this.labelText = 'Password',
    this.validatorText = 'Password enter your password',
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      // REMOVED explicit InputDecoration styling for border and label color.
      // These will now be inherited from ThemeData's inputDecorationTheme in main.dart.
      decoration: InputDecoration(
        labelText: widget.labelText,
        // If you need an icon, add it here:
        // prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColor, // Ensures eye icon uses the blue theme
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validatorText;
        }
        return null;
      },
    );
  }
}