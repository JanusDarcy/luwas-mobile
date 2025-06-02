import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luwas_travel_app/components/map_tab.dart';
import 'booking_form_page.dart';

class DestinationDetailPage extends StatefulWidget {
  final Map<String, dynamic> destination;

  const DestinationDetailPage({super.key, required this.destination});

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the top padding (safe area inset)
    final double topPadding = MediaQuery.of(context).padding.top;
    // You can print the topPadding here to confirm its value for debugging
    // print('Top Padding: $topPadding');

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    // The main image
                    Image.asset(
                      widget.destination['image'],
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Back Button
                    Positioned(
                      top: topPadding + 10, // Adjusted for safe area
                      left: 16,
                      child: Container(
                        // Removed debugging color, as we confirmed positioning
                        // color: Colors.red.withOpacity(0.3),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20, // Explicitly set radius for better control
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black, // <-- Set icon color to black
                              size: 24, // <-- Explicitly set icon size
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                    // Menu Button
                    Positioned(
                      top: topPadding + 10, // Adjusted for safe area
                      right: 16,
                      child: Container(
                        // Removed debugging color
                        // color: Colors.green.withOpacity(0.3),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20, // Explicitly set radius for better control
                          child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.black, // <-- Set icon color to black
                              size: 24, // <-- Explicitly set icon size
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.destination['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            'Philippines',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('1 Day', style: GoogleFonts.poppins()),
                          const SizedBox(width: 16),
                          const Icon(Icons.air, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('12 MPH South', style: GoogleFonts.poppins()),
                          const SizedBox(width: 16),
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${widget.destination['rating']}', style: GoogleFonts.poppins()),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        tabs: const [
                          Tab(text: 'Description'),
                          Tab(text: 'Gallery'),
                          Tab(text: 'Reviews'),
                          Tab(text: 'Map'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 300,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              child: Text(
                                widget.destination['description'] ?? 'No description available.',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Gallery for ${widget.destination['title']}',
                                style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                            ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index) => ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title: Text('User $index'),
                                subtitle: const Text('Very beautiful place! Would visit again.'),
                              ),
                            ),
                            MapTab(
                              latitude: widget.destination['latitude'] ?? 11.9695,
                              longitude: widget.destination['longitude'] ?? 121.9278,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Cost:',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      '₱${widget.destination['price']}',
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingFormPage(destination: widget.destination),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Book Now',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
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