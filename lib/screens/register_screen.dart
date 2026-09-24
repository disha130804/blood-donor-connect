import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../services/auth_service.dart';
import 'package:geolocator/geolocator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedBloodGroup = "A+";

  final List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  double? latitude;
  double? longitude;
  Future<void> getCurrentLocation() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position =
    await Geolocator.getCurrentPosition();

    latitude = position.latitude;
    longitude = position.longitude;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 80,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: nameController,
              hint: "Full Name",
              icon: Icons.person,
            ),

            const SizedBox(height: 15),

            CustomTextField(
              controller: emailController,
              hint: "Email",
              icon: Icons.email,
            ),

            const SizedBox(height: 15),

            CustomTextField(
              controller: phoneController,
              hint: "Phone Number",
              icon: Icons.phone,
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField(
              value: selectedBloodGroup,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
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

            CustomTextField(
              controller: cityController,
              hint: "City",
              icon: Icons.location_city,
            ),

            const SizedBox(height: 15),

            CustomTextField(
              controller: passwordController,
              hint: "Password",
              icon: Icons.lock,
              obscure: true,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "REGISTER",
              onPressed: () async {

                await getCurrentLocation();

                String? result = await AuthService().registerUser(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: phoneController.text.trim(),
                  city: cityController.text.trim(),
                  bloodGroup: selectedBloodGroup,
                  password: passwordController.text.trim(),
                  latitude: latitude,
                  longitude: longitude,
                );

                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Registration Successful"),
                    ),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}