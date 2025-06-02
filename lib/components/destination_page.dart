// lib/pages/destination_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luwas_travel_app/components/destination_detail_page.dart'; // Ensure this import is present

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  String _selectedCategory = 'Popular';

  final List<Map<String, dynamic>> _popularDestinations = const [
    {
      'title': 'Boracay',
      'image': 'assets/images/boracay.jpg',
      'rating': 4.9,
      'description': 'Famous for its stunning white beach and vibrant nightlife, Boracay offers powdery sands and crystal-clear waters, perfect for swimming and sunbathing. Enjoy water sports, explore Diniwid Beach, or simply relax and take in the beautiful sunsets.',
      'price': 3500.00, // Placeholder price for Boracay
    },
    {
      'title': 'El Nido',
      'image': 'assets/images/elnido.jpg',
      'rating': 4.8,
      'description': 'Known for its limestone cliffs, pristine beaches, and hidden lagoons, El Nido is a tropical paradise in Palawan. Island hopping tours will take you to breathtaking spots like Big Lagoon, Small Lagoon, and Secret Lagoon, offering unparalleled natural beauty.',
      'price': 18500.00, // Placeholder price for El Nido
    },
    {
      'title': 'Palawan',
      'image': 'assets/images/palawan.jpg',
      'rating': 4.7,
      'description': 'Home to natural wonders like the Puerto Princesa Underground River and captivating islands, Palawan is consistently voted one of the best islands in the world. Its diverse marine life and lush landscapes make it ideal for adventurers and nature lovers.',
      'price': 16000.00, // Placeholder price for Palawan
    },
    {
      'title': 'Vigan',
      'image': 'assets/images/vigan.webp',
      'rating': 4.5,
      'description': 'A UNESCO World Heritage site, Vigan is a remarkably preserved Spanish colonial town in Ilocos Sur. Stroll along Calle Crisologo, ride a kalesa, and admire the ancestral houses that transport you back in time. Don\'t miss the famous Vigan Empanada!',
      'price': 9500.00, // Placeholder price for Vigan
    },
    {
      'title': 'Sagada',
      'image': 'assets/images/sagada.webp',
      'rating': 4.6,
      'description': 'Nestled in the Cordillera mountains, Sagada is known for its mystical hanging coffins, stunning caves (like Sumaguing Cave), and cool mountain climate. It\'s a perfect destination for trekking, caving, and experiencing indigenous culture.',
      'price': 5000.00, // Placeholder price for Sagada
    },
    {
      'title': 'Batanes',
      'image': 'assets/images/batanes.webp',
      'rating': 5.0,
      'description': 'The northernmost province of the Philippines, Batanes boasts unique landscapes with rolling hills, traditional stone houses, and dramatic cliffs overlooking the sea. It offers a serene escape and a truly unique cultural experience.',
      'price': 8000.00, // Placeholder price for Batanes
    },
    // Add more Philippine destinations with descriptions and prices if needed
  ];

  @override
  Widget build(BuildContext context) {
    // ... (rest of your DestinationPage build method remains the same)
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 0,
              floating: true,
              pinned: false,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                onPressed: () {
                  Navigator.pop(context);
                },
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
                            'Hello, Giesha Lequin!',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    Text(
                      'Find your sweetest',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'Destinations',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCategoryTabs(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final destination = _popularDestinations[index];
                    return _buildDestinationCard(context, destination);
                  },
                  childCount: _popularDestinations.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      children: [
        _buildCategoryTab('Popular'),
        const SizedBox(width: 16),
        _buildCategoryTab('Rating'),
        const SizedBox(width: 16),
        _buildCategoryTab('Recommended'),
      ],
    );
  }

  Widget _buildCategoryTab(String title) {
    final bool isSelected = _selectedCategory == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.black87 : Colors.grey[600],
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(BuildContext context, Map<String, dynamic> destination) {
    return GestureDetector(
      onTap: () {
        // Navigate to the new DestinationDetailPage, passing the destination data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(destination: destination),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  destination['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber[400], size: 18),
                        const SizedBox(width: 4),
                        Text(
                          destination['rating'].toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
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
}