import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BecomeDonorScreen extends StatefulWidget {
  const BecomeDonorScreen({super.key});

  @override
  State<BecomeDonorScreen> createState() => _BecomeDonorScreenState();
}

class _BecomeDonorScreenState extends State<BecomeDonorScreen> {
  bool isAvailable = true;
  DateTime? lastDonationDate;

  final TextEditingController contactController =
  TextEditingController();

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        lastDonationDate = picked;
      });
    }
  }

  Future<void> becomeDonor() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({
      "isDonor": true,
      "isAvailable": isAvailable,
      "emergencyContact": contactController.text.trim(),
      "lastDonationDate":
      lastDonationDate?.toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "You are now a Blood Donor ❤️",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        title: const Text(
          "Become Donor",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Become a Blood Donor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "One donation can save multiple lives.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SwitchListTile(
                title: const Text(
                  "Available For Donation",
                ),
                subtitle: const Text(
                  "Show yourself to people searching donors",
                ),
                value: isAvailable,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() {
                    isAvailable = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Emergency Contact",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.red,
              ),
              title: const Text(
                "Last Donation Date",
              ),
              subtitle: Text(
                lastDonationDate == null
                    ? "Not Selected"
                    : "${lastDonationDate!.day}/${lastDonationDate!.month}/${lastDonationDate!.year}",
              ),
              trailing: TextButton(
                onPressed: selectDate,
                child: const Text("Select"),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.favorite),
                label: const Text(
                  "Become Donor",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
                onPressed: becomeDonor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}