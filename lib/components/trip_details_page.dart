// lib/components/trip_details_page.dart

import 'package:flutter/material.dart';
import 'package:luwas_travel_app/theme/app_text_style.dart'; // Import AppTextStyle
import 'package:luwas_travel_app/components/day_planner_page.dart'; // Import DayPlannerPage

class TripDetailsPage extends StatelessWidget {
  final Map<String, dynamic> trip;
  const TripDetailsPage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final days = [
      {"label": "Day 1", "date": "Fri 29"},
      {"label": "Day 2", "date": "Sat 30"},
      {"label": "Day 3", "date": "Sun 31 [today]"},
      {"label": "Day 4", "date": "Mon 1"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          trip['location']!,
          style: AppTextStyle.bold(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            child: Image.asset(
              trip['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(
              "Departing Flight",
              style: AppTextStyle.semiBold(
                fontSize: 18,
                color: Theme.of(context).primaryColor, // Use primary blue
              ),
            ),
            subtitle: Text(
              "Manila → Palawan • Thu, May 28 • 12h 30m",
              style: AppTextStyle.regular(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.clear, color: Colors.red.shade400),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 1.0,
              color: Colors.grey.shade300,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                return ListTile(
                  title: Text(
                    day['label']!,
                    style: AppTextStyle.semiBold(
                      fontSize: 16,
                      color: (day['label']!.contains('[today]'))
                          ? Theme.of(context).primaryColor
                          : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    day['date']!,
                    style: AppTextStyle.regular(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DayPlannerPage(day: day['label']!, date: day['date']!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}