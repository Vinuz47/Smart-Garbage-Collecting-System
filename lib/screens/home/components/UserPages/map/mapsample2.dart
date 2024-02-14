import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/screens/home/components/UserPages/map/location_service.dart';
import 'package:shop_app/screens/home/components/UserPages/reusable_widget/MongoDBModel.dart';
import 'package:shop_app/screens/home/components/mongodb.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample2(longi: 80.7718, latit: 7.8731),
    );
  }
}

class MapSample2 extends StatefulWidget {
  final double latit;
  final double longi;

  const MapSample2({super.key, required this.latit, required this.longi});

  @override
  State<MapSample2> createState() => MapSampleState(latitude: latit, longitude: longi);
}

class MapSampleState extends State<MapSample2> {
  final double latitude;
  final double longitude;
  //AsyncSnapshot snapshot =const AsyncSnapshot.nothing();

  MapSampleState({required this.latitude, required this.longitude});

  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  final Set<Polyline> _polylines = <Polyline>{};
  final List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static const CameraPosition _kGooglePlex = CameraPosition(
    //children[];
    target: LatLng(7.8731, 80.7718), // Sri lanka (First view once map load)
    zoom: 7.4746, // Zoom level
    //target: LatLng(6.8511, 79.9212),
    //zoom: 14.4746,
  );

  @override
  // void initState( ) {

  //   super.initState();
  //   //setMarker(const LatLng(5.9496, 80.5469));//Mathara
  //   callingFunction(mongoDbModelFromJson());

  // }
  void initState() {
    super.initState();
    FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  //  backgroundColor: Colors.blue,
                  ),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data.length;
              print("Total Data$totalData");
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    callingFunction(MongoDbModel.fromJson(snapshot.data[index]));
                    return null;
                  });
            } else {
              return const Center(
                child: Text("No Data Available."),
              );
            }
          }
        });
    //callingFunction(MongoDbModel.fromJson(snapshot.data[index]));

    setMarker(const LatLng(5.9496, 80.5469)); //Mathara
    setMarker(const LatLng(7.2906, 80.6337)); //Kandy
    setMarker(const LatLng(7.4818, 80.3609)); //Kurunagala
    setMarker(const LatLng(6.9934, 81.0550)); //Badulla
    // setMarker(const LatLng(8.3114, 80.4037));//Anuradhapura
    //setMarker(LatLng(latitude, longitude));
    //callingFunction(MongoDbModel.fromJson(snapshot.data[index]));
    setMarker(const LatLng(8.5874, 81.2152)); //Trinco
    setMarker(const LatLng(6.1429, 81.1212)); //Hambanthota
    setMarker(const LatLng(6.7056, 80.3847)); //Rathnapura
    setMarker(const LatLng(6.8511, 79.9212)); //Maharagama Location
    setMarker(const LatLng(6.830118, 79.880083)); // Dehiwala Location
    setMarker(const LatLng(8.0407913, 79.839386)); //Puthalama locaion
    //_setMarker(LatLng());
  }

  void callingFunction(MongoDbModel data) {
    print("ya hoo   ${data.latid}");
    print("yakkk  ${data.longi}");
    setMarker(LatLng(double.parse(data.latid), double.parse(data.longi)));
  }

  void setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: Column(
        children: [
          // FutureBuilder(
          //   future: MongoDatabase.getData() ,builder: (context, AsyncSnapshot snapshot) {
          //     if(snapshot.connectionState == ConnectionState.waiting){
          //       return Center(child: CircularProgressIndicator(
          //       //  backgroundColor: Colors.blue,
          //       ),
          //       );
          //     }else{
          //       if(snapshot.hasData){
          //         var totalData = snapshot.data.length;
          //         print("Total Data" + totalData.toString());
          //         return ListView.builder(

          //           itemCount: snapshot.data.length,
          //           itemBuilder: (context, index) {
          //           callingFunction(
          //             MongoDbModel.fromJson(snapshot.data[index]));

          //         });
          //       }else{
          //         return Center(child: Text("No Data Available."),
          //         );
          //       }
          //     }
          //   }
          // ),

          Row(
            children: [
              const Expanded(
                child: Column(
                  children: [
                    //                   FutureBuilder(
                    //                     future: MongoDatabase.getData() ,builder: (context, AsyncSnapshot snapshot) {
                    //             if(snapshot.connectionState == ConnectionState.waiting){
                    //               return Center(child: CircularProgressIndicator(
                    //               //  backgroundColor: Colors.blue,
                    //               ),
                    //               );
                    //             }else{
                    //               if(snapshot.hasData){
                    //                 var totalData = snapshot.data.length;
                    //                 print("Total Data" + totalData.toString());
                    //                 return ListView.builder(

                    //                   itemCount: snapshot.data.length,
                    //                   itemBuilder: (context, index) {
                    //                   callingFunction( MongoDbModel.fromJson(snapshot.data[index]));
                    //                     void initState() {
                    //   super.initState();
                    //   // setMarker(const LatLng(5.9496, 80.5469));//Mathara
                    //   // setMarker(const LatLng(7.2906, 80.6337));//Kandy
                    //   // setMarker(const LatLng(7.4818, 80.3609));//Kurunagala
                    //   // setMarker(const LatLng(6.9934, 81.0550));//Badulla
                    //   // setMarker(const LatLng(8.3114, 80.4037));//Anuradhapura
                    //   //setMarker(LatLng(latitude, longitude));
                    //   callingFunction(MongoDbModel.fromJson(snapshot.data[index]));
                    //   // setMarker(const LatLng(8.5874, 81.2152));//Trinco
                    //   // setMarker(const LatLng(6.1429, 81.1212));//Hambanthota
                    //   // setMarker(const LatLng(6.7056, 80.3847));//Rathnapura
                    //   // setMarker(const LatLng(6.8511, 79.9212)); //Maharagama Location
                    //   // setMarker(const LatLng(6.830118, 79.880083)); // Dehiwala Location
                    //   // setMarker(const LatLng(8.0407913, 79.839386));//Puthalama locaion
                    //   //_setMarker(LatLng());

                    // }

                    //                 });
                    //               }else{
                    //                 return Center(child: Text("No Data Available."),
                    //                 );
                    //               }
                    //             }
                    //           }
                    //                   )
                    // TextFormField(
                    //   controller: _originController,
                    //   decoration: InputDecoration(hintText: ' Origin'),
                    //   onChanged: (value) {
                    //     print(value);
                    //   },
                    // ),
                    // TextFormField(
                    //   controller: _destinationController,
                    //   decoration: InputDecoration(hintText: ' Destination'),
                    //   onChanged: (value) {
                    //     print(value);
                    //   },
                    // ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirections(
                    _originController.text,
                    _destinationController.text,
                  );
                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(directions['polyline_decoded']);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    // Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    setMarker(LatLng(lat, lng));
  }
}
