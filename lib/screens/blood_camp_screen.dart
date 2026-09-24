import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'camp_details_screen.dart';

class BloodCampScreen extends StatelessWidget {
  const BloodCampScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donation Camps"),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("blood_camps")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text("No Camps Available"),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var camp = docs[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(
                    Icons.bloodtype,
                    color: Colors.red,
                  ),
                  title: Text(camp["campName"]),
                  subtitle: Text(
                    "${camp["date"]}\n${camp["venue"]}",
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CampDetailsScreen(
                          campData: camp.data()
                          as Map<String, dynamic>,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}