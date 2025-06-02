// lib/components/home_screen.dart

import 'package:flutter/material.dart';
// Removed GoogleFonts import as we are now using AppTextStyle everywhere
// import 'package:google_fonts/google_fonts.dart';

// Assuming you have these pages for navigation (ensure paths are correct)
import 'package:luwas_travel_app/components/itinerary_page.dart';
import 'package:luwas_travel_app/screens/profile_page.dart';
import 'package:luwas_travel_app/components/travel_history_page.dart';
import 'package:luwas_travel_app/components/destination_page.dart'; // Your Explore page
import 'package:luwas_travel_app/theme/app_text_style.dart'; // Import AppTextStyle
import 'package:luwas_travel_app/screens/travel_package_details_page.dart'; // NEW: Import your new page
import 'package:luwas_travel_app/components/chat_support_page.dart'; // NEW: Import your new chat support page

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> discoverSections = const [
    {
      "title": "Baguio",
      "image": "assets/images/baguio.jpg",
      "route": "/destinations", // Will navigate to DestinationPage (Explore view)
    },
    {
      "title": "Cebu",
      "image": "assets/images/cebu.jpg",
      "route": "/destinations", // Will navigate to DestinationPage (Explore view)
    },
    {
      "title": "Bohol",
      "image": "assets/images/bohol.webp",
      "route": "/destinations", // Will navigate to DestinationPage (Explore view)
    },
  ];

  final List<Map<String, dynamic>> pastTripsShortList = const [
    {
      "location": "Siargao",
      "image": "assets/images/siargao.webp",
      "route": "/travel-history", // This will lead to the full TravelHistoryPage
    },
    {
      "location": "Boracay",
      "image": "assets/images/boracay.jpg",
      "route": "/travel-history",
    },
    {
      "location": "Palawan",
      "image": "assets/images/palawan.jpg",
      "route": "/travel-history",
    },
  ];

  // NEW: Data for the "Travel Packages" card on the Home Screen
  final Map<String, dynamic> boholCountrysideTourPackage = const {
    "title": "Bohol Day Tour All In Package",
    "image": "assets/images/bohol.webp", // Use a specific image for this package
    "departure": "Tagbilaran",
    "rating": 4.8,
    "reviews": 195,
    "bookedCount": "4K+",
    "price": "2,488", // Keep as String if you're displaying it as is with currency symbol
    "tags": ["English", "Private group", "Hotel pick up"],
    "description": "Explore the most popular Bohol Countryside attractions with your family and friends in a 6 to 8-hour day tour."
    // You can add more detailed itinerary data here if needed, or fetch it dynamically
  };


  final List<Map<String, dynamic>> bottomNavItems = const [
    {"title": "Home", "icon": Icons.home, "route": "/home"},
    {"title": "Explore", "icon": Icons.search, "route": "/destinations"}, // Links to DestinationPage
    {"title": "Chat", "icon": Icons.chat_bubble_outline, "route": "/chat_support"}, // NEW: Chat Support
    {"title": "Itinerary", "icon": Icons.calendar_month, "route": "/itineraries"},
    {"title": "Profile", "icon": Icons.person, "route": "/profile"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final String targetRoute = bottomNavItems[index]["route"] as String;
    if (ModalRoute.of(context)?.settings.name != targetRoute) {
      Navigator.pushNamed(context, targetRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your primary blue color from your theme
    final Color primaryBlue = Theme.of(context).primaryColor; // Assumed to be Color(0xFF003165)

    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F7), // Light blue background for the whole page
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            pinned: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.apps, color: primaryBlue), // Use primaryBlue
                  onPressed: () {
                    // Handle menu button press
                  },
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Giesha Lequin',
                          style: AppTextStyle.semiBold( // Use AppTextStyle
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '📍 Lucena, Quezon',
                          style: AppTextStyle.regular( // Use AppTextStyle
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 16),

                  Text(
                    'Travel Packages',
                    style: AppTextStyle.bold( // Use AppTextStyle
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Pass the specific package data to the builder
                  _buildTravelPackageCard(context, boholCountrysideTourPackage),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discover',
                        style: AppTextStyle.bold( // Use AppTextStyle
                          fontSize: 22,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/destinations");
                        },
                        child: Text(
                          'See more',
                          style: AppTextStyle.semiBold( // Use AppTextStyle
                            color: primaryBlue, // Use primary blue for links
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: discoverSections.length,
                      itemBuilder: (context, index) {
                        final item = discoverSections[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _buildDiscoverCard(context, item),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Travel History',
                        style: AppTextStyle.bold( // Use AppTextStyle
                          fontSize: 22,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/travel-history");
                        },
                        child: Text(
                          'See more',
                          style: AppTextStyle.semiBold( // Use AppTextStyle
                            color: primaryBlue, // Use primary blue for links
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pastTripsShortList.length,
                      itemBuilder: (context, index) {
                        final item = pastTripsShortList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _buildPastTripHighlightCard(context, item),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildCustomBottomNavBar(primaryBlue), // Pass primaryBlue
    );
  }

  // --- Helper Widgets ---

  // Updated _buildTravelPackageCard to navigate to TravelPackageDetailsPage
  Widget _buildTravelPackageCard(BuildContext context, Map<String, dynamic> packageData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TravelPackageDetailsPage(packageData: packageData),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Image.asset(
                packageData['image'], // Use specific package image
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.luggage, color: Colors.white, size: 20), // Changed icon
                        const SizedBox(width: 8),
                        Text(
                          packageData['title'], // Use package title
                          style: AppTextStyle.bold( // Use AppTextStyle
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Starting from ₱${packageData['price']}', // Use package price
                      style: AppTextStyle.regular( // Use AppTextStyle
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverCard(BuildContext context, Map<String, dynamic> item) {
    // Retrieve primary blue from theme for consistency
    final Color primaryBlue = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, item['route']),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Image.asset(
                item['image'],
                height: 200,
                width: 180,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  item['title'],
                  style: AppTextStyle.semiBold( // Use AppTextStyle
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPastTripHighlightCard(BuildContext context, Map<String, dynamic> item) {
    // Retrieve primary blue from theme for consistency
    final Color primaryBlue = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, item['route']),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Image.asset(
                item['image'],
                height: 200,
                width: 180,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  item['location'],
                  style: AppTextStyle.semiBold( // Use AppTextStyle
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomBottomNavBar(Color primaryBlue) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(bottomNavItems.length, (index) {
          final item = bottomNavItems[index];
          final bool isSelected = ModalRoute.of(context)?.settings.name == item["route"];

          return Expanded(
            child: InkWell(
              onTap: () {
                if (!isSelected) {
                  _onItemTapped(index);
                }
              },
              customBorder: const CircleBorder(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item["icon"] as IconData,
                    color: isSelected ? primaryBlue : Colors.grey[600],
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item["title"] as String,
                    style: isSelected // Corrected: Use bold style if selected
                        ? AppTextStyle.bold(
                            color: primaryBlue,
                            fontSize: 12,
                          )
                        : AppTextStyle.regular(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}