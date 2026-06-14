import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateHospitalScreen extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> hospitalData;

  const UpdateHospitalScreen({
    super.key,
    required this.docId,
    required this.hospitalData,
  });

  @override
  State<UpdateHospitalScreen> createState() =>
      _UpdateHospitalScreenState();
}

class _UpdateHospitalScreenState
    extends State<UpdateHospitalScreen> {

  late TextEditingController requirementController;

  @override
  void initState() {
    super.initState();

    requirementController = TextEditingController(
      text: widget.hospitalData["requirement"] ?? "",
    );
  }

  Future<void> updateRequirement() async {

    await FirebaseFirestore.instance
        .collection("hospitals")
        .doc(widget.docId)
        .update({
      "requirement": requirementController.text,
      "updatedAt": Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Requirement Updated"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Requirement"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: requirementController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Blood Requirement",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateRequirement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}