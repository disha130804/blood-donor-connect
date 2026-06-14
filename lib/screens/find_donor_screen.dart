import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindDonorScreen extends StatefulWidget {
  const FindDonorScreen({super.key});

  @override
  State<FindDonorScreen> createState() => _FindDonorScreenState();
}

class _FindDonorScreenState extends State<FindDonorScreen> {

  String selectedBlood = "A+";
  String city = "";

  final List<String> bloodGroups = [
    "A+","A-","B+","B-","AB+","AB-","O+","O-"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Donor"),
        backgroundColor: Colors.red,
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

                      return Card(

                        elevation:4,

                        margin: const EdgeInsets.only(bottom:10),

                        child: ListTile(

                          leading: CircleAvatar(

                            backgroundColor: Colors.red,

                            child: Text(
                              data["bloodGroup"],
                              style: const TextStyle(color: Colors.white),
                            ),

                          ),

                          title: Text(data["name"]),

                          subtitle: Text(
                            "${data["city"]}\n${data["phone"]}",
                          ),

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