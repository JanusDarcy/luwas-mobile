// lib/pages/destination_detail_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for currency formatting

class DestinationDetailPage extends StatefulWidget {
  final Map<String, dynamic> destination;

  const DestinationDetailPage({super.key, required this.destination});

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // For Description, Gallery, Reviews
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for the page
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0, // Height of the image section
            floating: true,
            pinned: true,
            backgroundColor: Colors.transparent, // Background will be covered by the image
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black), // Menu icon from design
                    onPressed: () {
                      // Handle menu action
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Destination Image
                  Image.asset(
                    widget.destination['image'],
                    fit: BoxFit.cover,
                  ),
                  // Gradient Overlay for text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                  // Content Overlay (Title, Location, Metrics)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.destination['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              // Using a generic "Philippines" for now, or you can add specific city/province
                              // to your destination data if needed.
                              'Philippines',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Metrics row: 1 Day, 12 MPH South (placeholder), Rating
                        Row(
                          children: [
                            _buildMetricItem(Icons.access_time, '1 Day', color: Colors.white),
                            const SizedBox(width: 16),
                            _buildMetricItem(Icons.wind_power, '12 MPH South', color: Colors.white), // Placeholder, can be removed
                            const SizedBox(width: 16),
                            _buildMetricItem(Icons.star_rounded, widget.destination['rating'].toString(), color: Colors.yellow),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tab Bar
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color.fromARGB(255, 0, 123, 255), // Matches the design's indicator
                        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
                        tabs: const [
                          Tab(text: 'Place Description'),
                          Tab(text: 'Gallery'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Tab Bar View Content
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Place Description Tab Content
                            SingleChildScrollView(
                              child: Text(
                                widget.destination['description'] ?? 'No description available for this destination.',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            // Gallery Tab Content (Placeholder)
                            Center(
                              child: Text(
                                'Gallery for ${widget.destination['title']}',
                                style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                            // Reviews Tab Content (Placeholder)
                            Center(
                              child: Text(
                                'Reviews for ${widget.destination['title']}',
                                style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBookingBar(context),
    );
  }

  Widget _buildMetricItem(IconData icon, String text, {Color color = Colors.white}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBookingBar(BuildContext context) {
    // Get the price from the destination data
    final double? price = widget.destination['price'] as double?;

    // Format the price to Philippine Peso
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'en_PH', // Use Philippine locale for formatting
      symbol: '₱',    // Philippine Peso symbol
      decimalDigits: 2, // Two decimal places
    );

    final String formattedPrice = price != null
        ? currencyFormatter.format(price)
        : 'Price N/A'; // Handle case where price might be missing

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Cost:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                formattedPrice, // Display the formatted price
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking ${widget.destination['title']} for $formattedPrice...')),
              );
              // Implement actual booking logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 123, 255), // Matches the design's button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text(
              'Book Now',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}