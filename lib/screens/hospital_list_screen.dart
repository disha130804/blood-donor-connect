import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update_hospital_screen.dart';

class HospitalListScreen extends StatelessWidget {
  const HospitalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospitals"),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("hospitals")
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
              child: Text("No Hospitals Registered"),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data =
              docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.local_hospital,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    data["hospitalName"] ?? "",
                  ),
                  subtitle: Text(
                    "${data["city"]}\nRequirement: ${data["requirement"]}",
                  ),
                  isThreeLine: true,

                ),
              );
            },
          );
        },
      ),
    );
  }
}