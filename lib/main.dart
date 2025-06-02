// main.dart

import 'package:luwas_travel_app/components/home_screen.dart'; // Your HomeScreen
import 'package:luwas_travel_app/components/home_section.dart'; // If you're using this for initial routing
import 'package:luwas_travel_app/components/itinerary_page.dart'; // Placeholder/Actual Itinerary Page
import 'package:luwas_travel_app/components/destination_page.dart'; // <--- ASSUMING THIS IS THE CORRECT PATH TO YOUR DETAILED DESTINATION PAGE
import 'package:luwas_travel_app/features/auth/email_password_login/pages/login_page.dart'; // Your login page
import 'package:luwas_travel_app/screens/profile_page.dart'; // Your profile page
import 'package:luwas_travel_app/screens/splash_screen.dart'; // Your splash screen
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:luwas_travel_app/components/travel_history_page.dart'; // IMPORTANT: Ensure this import points to your detailed TravelHistoryPage file
import 'package:luwas_travel_app/components/chat_support_page.dart'; // NEW: Import chat support page

import 'firebase_options.dart';

// Placeholder for SupportPage if it's not a separate file yet
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Support")),
      body: const Center(child: Text("Support Page")),
    );
  }
}

late FirebaseApp firebaseApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  firebaseApp = await Firebase.initializeApp(
    name: 'FirebaseAuthProviders',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luwas Travel App',
      theme: ThemeData(
        // Set your primary color to the dark blue from your palette
        primaryColor: const Color(0xFF003165), // This is the dark blue from your palette

        // You can also define an accent color for other elements if needed
        // For example, using the lighter blue from your palette
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF003165), // Explicitly set primary color for ColorScheme
          secondary: const Color(0xFF185C7C), // Use a lighter blue for accent/secondary color
          // You can define other colors here as well
          // surface: const Color(0xFF62B8C7), // Light blue for surfaces if desired
        ),


        // Define the default input decoration theme for all TextFields
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: const Color(0xFF003165), // Label text color
          ),
          floatingLabelStyle: TextStyle(
            color: const Color(0xFF003165), // Label text color when floating
          ),
          // Set fill color if text fields are filled
          // filled: true,
          // fillColor: Colors.grey[100], // A very light grey or your light blue palette color

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF003165), // Blue border when focused
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0), // Consistent rounded corners
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF185C7C), // Lighter blue border when enabled
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Keep error border red
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Keep error border red when focused
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder( // Default border for all states not explicitly defined
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        // If you're using text themes that should also be blue:
        // textTheme: TextTheme(
        //   headlineLarge: TextStyle(color: const Color(0xFF003165)),
        //   headlineMedium: TextStyle(color: const Color(0xFF003165)),
        //   bodyLarge: TextStyle(color: Colors.black87), // Example for body text
        // ),
        // If you have a ButtonThemeData, make sure it aligns with your primaryColor
        // buttonTheme: ButtonThemeData(
        //   buttonColor: const Color(0xFF003165),
        //   textTheme: ButtonTextTheme.primary, // This makes the button text color match the primary theme text
        // ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LogInPage(),
        '/home': (context) => const HomeSection(),
        '/welcome': (context) => const HomeScreen(),
        '/destinations': (context) => const DestinationPage(),
        '/itineraries': (context) => const ItineraryPage(),
        '/travel-history': (context) => const TravelHistoryPage(),
        '/support': (context) => const SupportPage(),
        '/profile': (context) => const ProfilePage(),
        '/chat_support': (context) => const ChatSupportPage(), // NEW: Chat Support route
      },
    );
  }
}