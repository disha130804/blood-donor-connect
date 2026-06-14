import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> donorData;

  const DonorDetailsScreen({
    super.key,
    required this.donorData,
  });

  Future<void> makeCall(String phone) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donor Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              donorData["name"] ?? "",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.bloodtype),
                title: const Text("Blood Group"),
                subtitle: Text(
                  donorData["bloodGroup"] ?? "",
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text("City"),
                subtitle: Text(
                  donorData["city"] ?? "",
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Phone"),
                subtitle: Text(
                  donorData["phone"] ?? "",
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.call),
                label: const Text("Call Donor"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  makeCall(
                    donorData["phone"],
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