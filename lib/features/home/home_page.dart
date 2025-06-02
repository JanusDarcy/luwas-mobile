import 'package:flutter/material.dart';
import 'package:luwas_travel_app/components/home_screen.dart';


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
