import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CampDetailsScreen extends StatelessWidget {

  final Map<String,dynamic> campData;

  const CampDetailsScreen({
    super.key,
    required this.campData,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Camp Details"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              campData["campName"],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text("Organizer: ${campData["organizer"]}"),
            Text("Date: ${campData["date"]}"),
            Text("Time: ${campData["time"]}"),
            Text("Venue: ${campData["venue"]}"),

            const SizedBox(height: 20),

            Text(campData["description"]),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.navigation),

                label: const Text("Navigate"),

                onPressed: () async {

                  final lat = campData["latitude"];
                  final lng = campData["longitude"];

                  final Uri url = Uri.parse(
                    "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng",
                  );

                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}