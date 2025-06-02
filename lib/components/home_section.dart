import 'package:flutter/material.dart';
import 'package:luwas_travel_app/components/home_screen.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: const Image(
              image: AssetImage('assets/images/palawan.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay
          Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Text + Button
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Discover Pre-Planned Adventures",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Explore curated travel experiences across the Philippines.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
               ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 0, 88, 182),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  ),
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  },
  child: const Text(
    "Start Exploring",
    style: TextStyle(fontSize: 16, color: Colors.white), // *** Changed text color to white ***
  ),
),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
