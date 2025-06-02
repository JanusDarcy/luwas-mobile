// lib/components/itinerary_page.dart

import 'package:flutter/material.dart';
import 'package:luwas_travel_app/theme/app_text_style.dart'; // Import AppTextStyle
import 'package:luwas_travel_app/components/trip_details_page.dart'; // Import TripDetailsPage

class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

  final List<Map<String, dynamic>> trips = const [
    {
      "location": "Palawan, Philippines",
      "date": "May 15, 2024",
      "days": 7,
      "image": "assets/images/palawan.jpg",
    },
    {
      "location": "Boracay, Philippines",
      "date": "April 20, 2024",
      "days": 5,
      "image": "assets/images/boracay.jpg",
    },
    {
      "location": "Siargao, Philippines",
      "date": "June 10, 2024",
      "days": 6,
      "image": "assets/images/siargao.webp",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Bookings',
          style: AppTextStyle.bold(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TripDetailsPage(trip: trip),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      trip['image'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip['location'],
                          style: AppTextStyle.bold(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${trip['date']} • ${trip['days']} days",
                          style: AppTextStyle.regular(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}