import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/home/MongoDB/Mongoconst.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shop_app/screens/home/components/UserPages/Points_transfer_customer.dart';

import 'utils/colours.dart';

class PointsView extends StatefulWidget {
  final String username;
  const PointsView({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<PointsView> createState() => _PointsViewState(username: username);
}

class _PointsViewState extends State<PointsView> {
  String username;
  _PointsViewState({required this.username});
  String? selectedValue;

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    int plasticPoints = 0;
    int glassPoints = 0;
    int tinPoints = 0;
    int paperPoints = 0;
    int cardboardPoints = 0;
    int electronicPoints = 0;
    int otherPoints = 0;
    int transferPoints = 0;
    int totalpoints = 0;
    double indicator;
    double indicatorDouble = 0;
    String usernamePoints = ' ';
    double indicatorpercentage = 0;

    Future<List<dynamic>> getData() async {
      var db = await mongo.Db.create(MONGO_URL);
      await db.open();
      inspect(db);
      final collection = db.collection(COLLECTION_NAME);
      final query = collection.find(mongo.where.eq('username', username)); //getting value from the db
      //final arrData = await collection.find().toList();
      //final document = await collection.findOne(query);
      final document = await query.first;

      plasticPoints = document['plastic'] as int;
      glassPoints = document['glass'] as int;
      tinPoints = document['tin'] as int;
      paperPoints = document['paper'] as int;
      cardboardPoints = document['cardboard'] as int;
      electronicPoints = document['electronic'] as int;
      otherPoints = document['other'] as int;
      transferPoints = document['points'] as int;
      print(
          "plastic : $plasticPoints, Glass: $glassPoints, tin:$tinPoints, paper:$paperPoints, cardboard:$cardboardPoints, electronic: $electronicPoints, other: $otherPoints, points: $transferPoints");
      totalpoints = plasticPoints + glassPoints + tinPoints + paperPoints + cardboardPoints + electronicPoints + otherPoints + transferPoints;
      if (totalpoints > 2000) {
        indicator = 1;
      } else {
        indicator = totalpoints / 2000;
      }

      print("Percentage = $indicator");
      indicatorDouble = indicator.toDouble();
      indicatorpercentage = indicatorDouble * 100;

      //final document = await query.first;
      final arrayField = document['items'];
      return List<dynamic>.from(arrayField);
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [hexStringToColor("006400"), hexStringToColor("35ab07"), hexStringToColor("095207")],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )
          //  colors: [Colors.purple, Colors.blue],
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Points Details"),
          backgroundColor: Colors.transparent,
          actions: [
            // PopupMenuButton<String>(
            //   icon: Icon(Icons.accessibility_new_outlined),
            //   initialValue: selectedValue,
            //   onSelected: (String newValue) {
            //     setState(() {
            //       selectedValue = newValue;
            //     });
            //   },
            //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            //   //  PopupMenuItem<String>(
            //      // value: 'Email: ${widget.email}',
            //      // child: Text('Email: ${widget.email}'),
            //    // ),
            //   ],
            // ),
            const SizedBox(width: 5),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: FutureBuilder(
                    future: getData(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: const Text(
                                "Your Virtual bin",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                              ),
                            ),

                            //child: Text("Your Virtual bin")
                            /* Transform.scale(
                                  scale: 2.0,
                                  child: CircularProgressIndicator(
                                    value: indicatorDouble, // Set the percentage as the value (between 0.0 and 1.0)
                                    backgroundColor: Colors.grey[300], // Background color
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), // Indicator color
                                    strokeWidth: 10, // Set the width of the circle
                                  ))*/
                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              CircularPercentIndicator(
                                radius: 120.0,
                                lineWidth: 13.0,
                                animation: true,
                                percent: indicatorDouble,
                                center: Text(
                                  "$indicatorpercentage %",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                                ),
                                footer: const Text(
                                  "Your virtual bin status",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.blue,
                              ),
                            ]),
                            Container(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(children: [
                                  Text("Plastic points: $plasticPoints"),
                                  Text("Glass Points: $glassPoints"),
                                  Text("Tin Points: $tinPoints"),
                                  Text("Paper Points: $paperPoints"),
                                  Text("CardBoard Points: $cardboardPoints"),
                                  Text("Electronic Points: $electronicPoints"),
                                  Text("Other Points: $otherPoints"),
                                  Text("Transfered Points: $transferPoints"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Total Points: $totalpoints",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ])),
                            const SizedBox(
                              width: 200,
                              height: 40,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.manage_search_sharp),
                              label: const Text(
                                "| Transfer Points",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                usernamePoints = '$username,$totalpoints';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Points_transfer_customer(
                                            ToPass: usernamePoints,
                                          )),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                fixedSize: const Size(280, 70),
                                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                elevation: 30,
                                shadowColor: Colors.black,
                                side: const BorderSide(color: Colors.black, width: 2),
                                shape: const StadiumBorder(),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: Text("No Data available: ${snapshot.error}"),
                        );
                      }
                    })),
              )
            ],
          ),
        )),
      ),
    );
  }
}
