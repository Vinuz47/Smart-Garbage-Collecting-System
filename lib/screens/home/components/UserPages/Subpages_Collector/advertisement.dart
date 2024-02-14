import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shop_app/screens/home/components/UserPages/display_wall.dart';
import 'package:shop_app/screens/home/components/UserPages/path_suggestion.dart';
import 'package:shop_app/screens/home/components/UserPages/reusable_widget/MongoDBModel.dart';
import 'package:shop_app/screens/home/components/UserPages/reusable_widget/text_field.dart';
import 'package:shop_app/screens/home/components/UserPages/reusable_widget/text_field2.dart';
import 'package:shop_app/screens/home/components/mongodb.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

class Advertisement extends StatefulWidget {
  //final TextEditingController locationController;
  final String locationAddress;
  final double longit;
  final double latid;
  final String username;
  Advertisement({
    super.key,
    required this.locationAddress,
    required this.longit,
    required this.latid,
    required this.username,
    //required this.locationController,
  });

  @override
  AdvertisementState createState() => AdvertisementState(longiAdv: longit, latiAdv: latid, username: username, locationAddress: locationAddress);
}

//text controller
final nameController = TextEditingController();
final itemsController = TextEditingController();
final itemUnitPrice = TextEditingController();

class AdvertisementState extends State<Advertisement> {
  String locationAddress;
  final double longiAdv;
  final double latiAdv;
  final String username;
  AdvertisementState({
    required this.locationAddress,
    required this.latiAdv,
    required this.longiAdv,
    required this.username,
  });

  final locationControllerlatid = TextEditingController(text: "1.0");
  final locationControllerlongi = TextEditingController(text: "0.0");
//var pg = PathSugessionState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 67, 12),
          shadowColor: Colors.yellow,
          title: const Text(
            "Advertisement",
            style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
          height: double.maxFinite,
          decoration:const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/en2.png',
              
              ),
              //opacity: 180,
              fit: BoxFit.fill,
              
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                //post message
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children:<Widget> [
                      const SizedBox(height: 60),
                      MyTextField(
                        icon: const Icon(Icons.person_2_outlined),
                        controller: nameController,
                        hintText: "Name",
                        obscureText: false,
                      ),

                      const SizedBox(height: 20),

                      MyTextField(
                        icon: const Icon(Icons.recycling_sharp),
                        controller: itemsController,
                        hintText: "Items",
                        obscureText: false,
                      ),

                      const SizedBox(height: 20),

                      MyTextField2(
                        icon: const Icon(Icons.price_change_outlined),
                        controller: itemUnitPrice,
                        hintText: "Unit Price (1kg)",
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),
                      
                      Text(
                        "Location: $locationAddress",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 10),
                      
                      Text(
                        "Longitude: $longiAdv",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Latitude: $latiAdv",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),

                    

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              //flex: 1,
                              //width: 50,
                              child: Column(
                                children: [
                                  ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PathSugession(
                                                username: username,
                                              )),
                                    );
                                  },
                                  
                              
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[600],
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("Set Location",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                  ),

                                  const SizedBox(height: 15),

                                ElevatedButton(
                                    
                                      onPressed: () {
                                        _postData(nameController.text, itemsController.text, itemUnitPrice.text, longiAdv.toString(), latiAdv.toString());
                                      },
                                      
                                      
                                      style: ElevatedButton.styleFrom(
                                        //width: 50,
                                        backgroundColor: Colors.red[600],
                                        foregroundColor: Colors.white,
                                      ),
                                      child:const Text("Post",
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      ),
                                      ),
                                      ),
                                ],
                              ),
                            ),
                            // ButtonStyle(shadowColor: Colors.amber)
                                const SizedBox(width: 5),
                          
                            const SizedBox(width: 5),
                            Expanded(
                           // flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MongoDbDisplay()),
                                    );
                                  },
                                  
                                  
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(115, 10),
                                    backgroundColor: Colors.green[600],
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("Go to Wall",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                  ),
                            ),
                          
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _postData(String name, String items, String unitPrice, String longi, String latid) async {
    var id = M.ObjectId(); //storing uniquID(key) inside our variable
    final data = MongoDbModel(
        id: id, username: username, name: name, items: items, unitPrice: unitPrice, longi: longi, latid: latid, locationAddress: locationAddress);
    var result = await MongoDatabase.postData(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID ${id.$oid}")));
    _clearAll();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Advertisement(longit: 0.0, latid: 0.0, username: username, locationAddress: " ")),
    );
  }

  void _clearAll() {
    nameController.text = "";
    itemsController.text = "";
    itemUnitPrice.text = "";
    locationControllerlongi.text = "";
    locationControllerlatid.text = "";
    locationAddress = "";
    //locationAddress = ""
  }
}
