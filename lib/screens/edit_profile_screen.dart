import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditProfileScreen({required this.userData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController bloodController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.userData['name']);
    phoneController = TextEditingController(text: widget.userData['phone']);
    cityController = TextEditingController(text: widget.userData['city']);
    bloodController =
        TextEditingController(text: widget.userData['bloodGroup']);
  }

  Future<void> updateProfile() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({
      "name": nameController.text,
      "phone": phoneController.text,
      "city": cityController.text,
      "bloodGroup": bloodController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            textField(nameController, "Name"),
            textField(phoneController, "Phone"),
            textField(cityController, "City"),
            textField(bloodController, "Blood Group"),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateProfile,
              child: Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }

  Widget textField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}