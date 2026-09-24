import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'donor_details_screen.dart';
import 'map_screen.dart';
import 'package:geolocator/geolocator.dart';

class FindDonorScreen extends StatefulWidget {
  const FindDonorScreen({super.key});


  @override
  State<FindDonorScreen> createState() => _FindDonorScreenState();
}

class _FindDonorScreenState extends State<FindDonorScreen> {
  double? userLatitude;
  double? userLongitude;

  String selectedBlood = "A+";
  String city = "";

  final List<String> bloodGroups = [
    "A+","A-","B+","B-","AB+","AB-","O+","O-"
  ];
  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      userLatitude = position.latitude;
      userLongitude = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Donor"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MapScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            DropdownButtonFormField(
              value: selectedBlood,

              items: bloodGroups.map((e){

                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );

              }).toList(),

              onChanged: (value){

                setState(() {

                  selectedBlood=value!;

                });

              },

            ),

            const SizedBox(height: 15),

            TextField(

              decoration: const InputDecoration(

                hintText: "Enter City",

                border: OutlineInputBorder(),

              ),

              onChanged: (value){

                setState(() {

                  city=value;

                });

              },

            ),

            const SizedBox(height:20),

            Expanded(

              child: StreamBuilder(

                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("bloodGroup", isEqualTo: selectedBlood)
                    .where("isDonor", isEqualTo: true)
                    .where("isAvailable", isEqualTo: true)
                    .snapshots(),

                builder: (context,snapshot){

                  if(!snapshot.hasData){

                    return const Center(
                      child:CircularProgressIndicator(),
                    );

                  }

                  var docs=snapshot.data!.docs;

                  docs=docs.where((doc){

                    String userCity=(doc["city"]??"").toString().toLowerCase();

                    return userCity.contains(city.toLowerCase());

                  }).toList();
                  if (userLatitude != null && userLongitude != null) {
                    docs.sort((a, b) {

                      double distanceA = Geolocator.distanceBetween(
                        userLatitude!,
                        userLongitude!,
                        a["latitude"],
                        a["longitude"],
                      );

                      double distanceB = Geolocator.distanceBetween(
                        userLatitude!,
                        userLongitude!,
                        b["latitude"],
                        b["longitude"],
                      );

                      return distanceA.compareTo(distanceB);
                    });
                  }


                  if(docs.isEmpty){

                    return const Center(

                      child: Text(
                        "No Donor Found",
                        style: TextStyle(fontSize:20),
                      ),

                    );

                  }

                  return ListView.builder(

                    itemCount: docs.length,

                    itemBuilder: (context,index){

                      var data=docs[index];
                      double distanceInKm = 0;

                      if (userLatitude != null &&
                          userLongitude != null &&
                          data["latitude"] != null &&
                          data["longitude"] != null) {

                        distanceInKm =
                            Geolocator.distanceBetween(
                              userLatitude!,
                              userLongitude!,
                              data["latitude"],
                              data["longitude"],
                            ) /
                                1000;
                      }

                      return Card(

                        elevation:4,

                        margin: const EdgeInsets.only(bottom:10),

                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text(
                              data["bloodGroup"],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data["name"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          subtitle: Text(
                            "${data["city"]}\n"
                                "${data["phone"]}\n"
                                "${distanceInKm.toStringAsFixed(1)} km away",
                          ),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DonorDetailsScreen(
                                  donorData: data.data(),
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

            )

          ],

        ),

      ),

    );

  }

}