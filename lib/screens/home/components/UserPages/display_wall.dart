import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/home/components/UserPages/map/mapsample.dart';
import 'package:shop_app/screens/home/components/UserPages/reusable_widget/MongoDBModel.dart';
import 'package:shop_app/screens/home/components/mongodb.dart';
//import 'package:animated_background/animated_background.dart';

class MongoDbDisplay extends StatefulWidget {

  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 67, 12),
        shadowColor: Colors.yellow,
        title: const Text(
          "Wall",
          style: TextStyle(fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 238, 233, 233),
            
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout),
        color: Colors.white,
        )],
      ),
      body: Container(
          color: const Color.fromARGB(255, 11, 11, 11),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
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
                      print("Total Data   $totalData");
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(MongoDbModel.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return const Center(
                        child: Text("No Data Available."),
                      );
                    }
                  }
                }),
          )),
    );
  }

//new
  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 5,
          ),
          //Text("Id: ${data.id.$oid}"),
          // const SizedBox(height: 5,),
          // Text("Username: "+"${data.username}"),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Name: ${data.name}",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Items Collecting: ${data.items}",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Unit Price(1kg): ${data.unitPrice}",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Location: ${data.locationAddress}",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          //Text("Longi: "+"${data.longi}"),

          Row(
            children: [

              //const SizedBox(width: 150),

              const Text("Click here to see location --> ",
              style: TextStyle(
                color: Color.fromARGB(255, 169, 7, 26),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton.icon(
                  
                  icon: const Icon(
                    Icons.location_on,
                    size: 15,
                   // color: Colors.blue,
                  ),
                  style:ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  label: const Text(
                    "| Location",
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample(latit: double.parse(data.latid), longi: double.parse(data.longi))),
                    );
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
