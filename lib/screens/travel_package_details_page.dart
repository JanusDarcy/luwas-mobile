// lib/screens/travel_package_details_page.dart

import 'package:flutter/material.dart';
import 'package:luwas_travel_app/theme/app_text_style.dart'; // Import your AppTextStyle
import 'package:intl/intl.dart'; // Import for currency formatting

class TravelPackageDetailsPage extends StatefulWidget {
  final Map<String, dynamic> packageData;

  const TravelPackageDetailsPage({super.key, required this.packageData});

  @override
  State<TravelPackageDetailsPage> createState() => _TravelPackageDetailsPageState();
}

class _TravelPackageDetailsPageState extends State<TravelPackageDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // For "Overview" and "Itinerary" tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define your primary and secondary colors from your theme
    final Color primaryBlue = Theme.of(context).primaryColor; // Assumed to be Color(0xFF003165)
    final Color destinationButtonBlue = const Color.fromARGB(255, 0, 123, 255); // From DestinationDetailPage

    // Format the price to Philippine Peso
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'en_PH', // Use Philippine locale for formatting
      symbol: '₱',    // Philippine Peso symbol
      decimalDigits: 2, // Two decimal places
    );

    // Ensure price is parsed as double before formatting
    // Also handle potential commas in the string price, by removing them first
    final String formattedPrice = widget.packageData['price'] != null
        ? currencyFormatter.format(double.parse(widget.packageData['price'].toString().replaceAll(',', '')))
        : 'Price N/A'; // Handle case where price might be missing

    return Scaffold(
      backgroundColor: Colors.white, // Clean white background for the page
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0, // Height of the image section
                floating: false,
                pinned: true,
                snap: false,
                backgroundColor: Colors.white, // AppBar background when scrolled up
                elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.only(left: 16, top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: primaryBlue),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.favorite_border, color: primaryBlue),
                            onPressed: () {
                              // Handle favorite
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.share, color: primaryBlue),
                            onPressed: () {
                              // Handle share
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.packageData['image'], // Use the image from packageData
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.photo_library, color: Colors.white, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Gallery',
                                  style: AppTextStyle.regular(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.packageData['title']!,
                            style: AppTextStyle.bold(
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Departing from ${widget.packageData['departure']}',
                            style: AppTextStyle.regular(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.star_rounded, color: Colors.amber[600], size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.packageData['rating']} (${widget.packageData['reviews']} reviews)',
                                style: AppTextStyle.semiBold(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${widget.packageData['bookedCount']} booked',
                                style: AppTextStyle.regular(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 4.0, // gap between lines
                            children: (widget.packageData['tags'] as List<String>)
                                .map((tag) => Chip(
                                      label: Text(
                                        tag,
                                        style: AppTextStyle.regular(
                                          fontSize: 12,
                                          color: primaryBlue,
                                        ),
                                      ),
                                      backgroundColor: primaryBlue.withOpacity(0.1),
                                      side: BorderSide(color: primaryBlue.withOpacity(0.3)),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.packageData['description']!,
                            style: AppTextStyle.regular(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Implement "See more" functionality, e.g., show full description in a dialog
                            },
                            child: Text(
                              'See more',
                              style: AppTextStyle.semiBold(
                                color: primaryBlue, // Use primary blue for links
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildGroupSizeSelection(primaryBlue), // Call new group size widget
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    // "See itinerary details" tab bar
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: primaryBlue,
                        unselectedLabelColor: Colors.grey[600],
                        indicatorColor: primaryBlue,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3.0,
                        labelStyle: AppTextStyle.semiBold(fontSize: 16),
                        unselectedLabelStyle: AppTextStyle.regular(fontSize: 16),
                        tabs: const [
                          Tab(text: "Overview"),
                          Tab(text: "Itinerary Details"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500, // Adjust height as needed for content
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Overview Tab Content
                          _buildOverviewTabContent(primaryBlue),
                          // Itinerary Details Tab Content
                          _buildItineraryDetailsTabContent(primaryBlue),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100), // Space for bottom bar
                  ],
                ),
              ),
            ],
          ),
          // Bottom Price and CTA Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBookingBar(primaryBlue, destinationButtonBlue, formattedPrice),
          ),
          // The FloatingActionButton for AI Assistant is removed from here
        ],
      ),
    );
  }

  Widget _buildGroupSizeSelection(Color primaryBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Group Size',
          style: AppTextStyle.semiBold(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 45, // Fixed height for chips
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildGroupChip('Group of 2-3', primaryBlue),
              _buildGroupChip('Group of 4-5', primaryBlue),
              _buildGroupChip('Group of 6-10', primaryBlue, isSelected: true), // Example selected
              _buildGroupChip('Custom', primaryBlue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupChip(String label, Color primaryBlue, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(
          label,
          style: AppTextStyle.regular(
            fontSize: 14,
            color: isSelected ? Colors.white : primaryBlue,
          ),
        ),
        selected: isSelected,
        selectedColor: primaryBlue,
        backgroundColor: primaryBlue.withOpacity(0.1),
        side: BorderSide(color: isSelected ? primaryBlue : primaryBlue.withOpacity(0.3)),
        onSelected: (selected) {
          // Handle selection logic here if needed for actual group size selection
          // For now, it's just visual.
        },
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildOverviewTabContent(Color primaryBlue) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Highlights:',
            style: AppTextStyle.semiBold(fontSize: 18, color: primaryBlue),
          ),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.location_on, 'Chocolate Hills', primaryBlue),
          _buildDetailRow(Icons.location_on, 'Tarsier Sanctuary', primaryBlue),
          _buildDetailRow(Icons.location_on, 'Bilar Man-Made Forest', primaryBlue),
          _buildDetailRow(Icons.location_on, 'Aproniana Gift Shop', primaryBlue),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.access_time, '09:00 - 17:00', primaryBlue),
          _buildDetailRow(Icons.delivery_dining, 'Departure type: Pick up', primaryBlue),
          _buildDetailRow(Icons.check_circle_outline, 'Free cancellation (24 hours notice)', primaryBlue),
          _buildDetailRow(Icons.check_circle_outline, '24-hour confirmation', primaryBlue),
          _buildDetailRow(Icons.group, 'Group size: 1 to 100', primaryBlue),
          const SizedBox(height: 24),
          Text(
            'What\'s Included:',
            style: AppTextStyle.semiBold(fontSize: 18, color: primaryBlue),
          ),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.check_circle_outline, 'Admission to attractions', primaryBlue),
          _buildDetailRow(Icons.check_circle_outline, 'Admission to: Chocolate Hills, Tarsier, Loboc/Loay Floating Restaurant', primaryBlue),
          _buildDetailRow(Icons.check_circle_outline, 'English-speaking professional driver/guide', primaryBlue),
          _buildDetailRow(Icons.check_circle_outline, 'Lunch', primaryBlue),
          // Add more included items as needed
        ],
      ),
    );
  }

  Widget _buildItineraryDetailsTabContent(Color primaryBlue) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Day 1: Bohol Highlights',
            style: AppTextStyle.bold(fontSize: 18, color: primaryBlue),
          ),
          const SizedBox(height: 8),
          _buildItineraryStep('09:00 AM', 'Pick up from Tagbilaran hotel.'),
          _buildItineraryStep('10:00 AM', 'Visit Chocolate Hills viewing deck.'),
          _buildItineraryStep('12:00 PM', 'Lunch at Loboc River floating restaurant.'),
          _buildItineraryStep('02:00 PM', 'Encounter Tarsiers at the Philippine Tarsier Sanctuary.'),
          _buildItineraryStep('04:00 PM', 'Explore the Bilar Man-Made Forest.'),
          _buildItineraryStep('05:00 PM', 'Return to hotel.'),
          const SizedBox(height: 24),
          Text(
            'Day 2: Optional Extension (Diving)',
            style: AppTextStyle.bold(fontSize: 18, color: primaryBlue),
          ),
          const SizedBox(height: 8),
          _buildItineraryStep('08:00 AM', 'Diving expedition in Panglao (PADI certified).'),
          _buildItineraryStep('12:00 PM', 'Lunch on Panglao Island.'),
          // Add more itinerary steps or days
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.regular(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItineraryStep(String time, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            alignment: Alignment.topRight,
            child: Text(
              time,
              style: AppTextStyle.semiBold(fontSize: 14, color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 2,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.only(left: 4, right: 14),
                      ),
                      Expanded(
                        child: Text(
                          description,
                          style: AppTextStyle.regular(fontSize: 15, color: Colors.black87),
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
    );
  }


  Widget _buildBottomBookingBar(Color primaryBlue, Color destinationButtonBlue, String formattedPrice) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // Display the raw price from packageData, as the design uses "P 2,488" without cents
                '₱ ${widget.packageData['price']}',
                style: AppTextStyle.bold(
                  fontSize: 24,
                  color: primaryBlue,
                ),
              ),
              // The LuwasCash row is now removed.
            ],
          ),
          // Changed to match DestinationDetailPage's Book Now button layout and style
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking ${widget.packageData['title']} for ${formattedPrice}...')),
              );
              // Implement actual booking logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: destinationButtonBlue, // Matches DestinationDetailPage's blue
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Matches DestinationDetailPage's radius
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Matches DestinationDetailPage's padding
            ),
            child: Text(
              'Book Now',
              style: AppTextStyle.bold( // Using AppTextStyle
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}