import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/home/components/UserPages/Subpages_Collector/advertisement.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:uuid/uuid.dart';

class PathSugession extends StatefulWidget {
  final String username;

  const PathSugession({
    super.key,
    required this.username,
  });

  @override
  PathSugessionState createState() => PathSugessionState(username: username);
}


class PathSugessionState extends State<PathSugession> {
  final String username;

  PathSugessionState({
    required this.username,
  });

  double longit = 0;
  String setLongi = " ";
  TextEditingController locationController = TextEditingController();
  final Set<Marker> _markers = <Marker>{};
  List<LatLng> polygonLatLngs = <LatLng>[];

  var uuid = const Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();

    locationController.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(locationController.text);
  }

  void getSuggestion(String input) async {
    String kplacesApiKey = 'AIzaSyD1_RvRolzVMI5UkqrAut_u6XObvE8W6v0';
    String type = '(regions)';

    try {
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';

      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body.toString())['predictions'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 67, 12),
        shadowColor: Colors.yellow,
        title: const Text(
          "Location",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              SafeArea(
                child: TextFormField(
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  controller: locationController,
                  decoration: InputDecoration(hintText: 'Type address here', border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))),
                ),
              ),

              // ),
              // Row(
              //   children: [
              Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(_placeList[index]['description']);
                          //print("Longitude");
                          longit = locations.last.longitude;

                          //printText(longit.toString());
                          // print(longit);

                          // print("Latitude");
                          double latit = locations.last.latitude;
                          //print(latit);
                          print(locations);
                          // print(locationFromAddress(_placeList[index]['description']));

                          String locationAddress = _placeList[index]['description'];

                          print(locationAddress);
                          // PathSugession(longit: longit);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Advertisement(longit: longit, latid: latit, username: username, locationAddress: locationAddress)),
                          );

                        
                        },
                        // ListTile(
                        title: Text(
                          _placeList[index]['description'],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        //   ),
                      );
                    }),
              ),
              
          

              
            ],
          )),
    );
  }

  void printText(String str) {
    Text(str);
  }
}
