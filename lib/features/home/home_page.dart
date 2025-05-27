import 'package:flutter/material.dart';
import 'package:email_password_login/components/home_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          HomeScreen(),
          SizedBox(height: 16),
         
        ],
      ),
    );
  }
}
