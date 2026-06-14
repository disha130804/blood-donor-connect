import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController patientController =
  TextEditingController();

  final TextEditingController hospitalController =
  TextEditingController();

  final TextEditingController contactController =
  TextEditingController();

  String selectedBloodGroup = "A+";

  final List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Emergency Request",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Create an urgent blood request for nearby donors.",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: patientController,
                decoration: const InputDecoration(
                  labelText: "Patient Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter patient name" : null,
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                value: selectedBloodGroup,
                decoration: const InputDecoration(
                  labelText: "Blood Group Needed",
                  border: OutlineInputBorder(),
                ),
                items: bloodGroups.map((group) {
                  return DropdownMenuItem(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBloodGroup = value!;
                  });
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: hospitalController,
                decoration: const InputDecoration(
                  labelText: "Hospital Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter hospital name" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter contact number" : null,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.emergency),
                  label: const Text("Submit Request"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      await FirebaseFirestore.instance
                          .collection('emergency_requests')
                          .add({
                        'patientName': patientController.text.trim(),
                        'bloodGroup': selectedBloodGroup,
                        'hospital': hospitalController.text.trim(),
                        'contact': contactController.text.trim(),
                        'timestamp': FieldValue.serverTimestamp(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Emergency Request Submitted Successfully!",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      patientController.clear();
                      hospitalController.clear();
                      contactController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}