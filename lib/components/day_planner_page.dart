// lib/components/day_planner_page.dart

import 'package:flutter/material.dart';
import 'package:email_password_login/theme/app_text_style.dart'; // Import AppTextStyle

class DayPlannerPage extends StatelessWidget {
  final String day;
  final String date;

  const DayPlannerPage({super.key, required this.day, required this.date});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {"time": "09:00", "activity": "Breakfast"},
      {"time": "11:00", "activity": "Explore Palawan Island"},
      {"time": "13:00", "activity": "Lunch @ Hennan"},
      {"time": "16:00", "activity": "Meet with Janus"},
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
          "Day Planner",
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
              "assets/images/palawan.jpg", // Make sure this image path is correct
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  day,
                  style: AppTextStyle.bold(
                    fontSize: 22,
                    color: Theme.of(context).primaryColor, // Primary blue for the day
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: AppTextStyle.regular(
                    fontSize: 14,
                    color: Colors.grey[600], // Standard grey for date
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 1.0,
              color: Colors.grey.shade300, // Lighter grey for separator
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: activities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final act = activities[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF62B8C7), // Using your light blue palette color
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [ // Optional: Add a subtle shadow to activity cards
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        act['time']!,
                        style: AppTextStyle.semiBold(
                          fontSize: 16,
                          color: const Color(0xFF003165), // Dark blue for time
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          act['activity']!,
                          style: AppTextStyle.regular(
                            fontSize: 16,
                            color: const Color(0xFF003165), // Dark blue for activity
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}