import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BecomeDonorScreen extends StatelessWidget {
  const BecomeDonorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become Donor"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 15,
            ),
          ),
          onPressed: () async {
            String uid = FirebaseAuth.instance.currentUser!.uid;

            await FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .update({
              "isDonor": true,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("You are now a Blood Donor ❤️"),
              ),
            );
          },
          child: const Text(
            "Become Donor",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}