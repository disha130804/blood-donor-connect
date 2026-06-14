import 'package:blood_donor_connect/screens/profile_screen.dart';
import 'package:blood_donor_connect/screens/view_requests_screen.dart';
import 'package:flutter/material.dart';
import 'find_donor_screen.dart';
import 'become_donor_screen.dart';
import 'emergency_screen.dart';
import 'view_requests_screen.dart';
import 'hospital_registration_screen.dart';
import 'hospital_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildCard(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 45),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Blood Donor Connect",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [

            buildCard(
              context,
              Icons.search,
              "Find Donor",
              Colors.red,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindDonorScreen(),
                  ),
                );
              },
            ),

            buildCard(
              context,
              Icons.emergency,
              "Emergency",
              Colors.deepOrange,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyScreen(),
                  ),
                );
              },
            ),
            buildCard(
              context,
              Icons.favorite,
              "Become Donor",
              Colors.pink,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BecomeDonorScreen(),
                      ),
                    );
                  },
            ),

            buildCard(
              context,
              Icons.person,
              "Profile",
              Colors.blue,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
            ),
            buildCard(
              context,
              Icons.list_alt,
              "View Requests",
              Colors.green,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewRequestsScreen(),
                  ),
                );
              },
            ),
            buildCard(
              context,
              Icons.local_hospital,
              "Register Hospital",
              Colors.teal,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const HospitalRegistrationScreen(),
                  ),
                );
              },
            ),
            buildCard(
              context,
              Icons.medical_services,
              "Hospital List",
              Colors.indigo,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const HospitalListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}