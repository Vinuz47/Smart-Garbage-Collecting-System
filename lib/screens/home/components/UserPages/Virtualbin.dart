import 'package:flutter/material.dart';
import 'Sending_DB.dart';

import 'utils/colours.dart';

class TestPage extends StatefulWidget {
  //const TestPage({Key? k, required int ToPassey}) : super(key: key);
  final String ToPass;
  //const TestPage({Key? key, required this.ToPass}) : super(key: key);
  const TestPage({super.key, required this.ToPass});

  @override
  State<TestPage> createState() => _TestPageState(ToPass: ToPass);
}

// Future<List<dynamic>> fetchmongo(String ToPass) async {
//   var db = await mongo.Db.create(MONGO_URL);
//   await db.open();
//   final collection = db.collection(COLLECTION_NAME);
//   // final query = await collection.find(
//   //   mongo.where.gt('username', 'Gethwan'),
//   // );
//   // final data = await query.toList();
//   final query = collection.find(
//     mongo.where.eq('username', ToPass),
//   );

//   final document = await query.first;
//   final arrayField = document['items'];
//   return List<dynamic>.from(arrayField);
//   // if (document != null) {
//   //   final arrayField = document['items'];

//   //   ListView.builder(
//   //     itemCount: arrayField.length,
//   //     itemBuilder: (context, index) {
//   //       return ListTile(
//   //         title: Text(arrayField[1].toString()),
//   //       );
//   //     },
//   //   );
//   // }
// }

class _TestPageState extends State<TestPage> {
  String ToPass;
  List<dynamic> data = [];
  bool isLoading = false;
  int page = 1;
  _TestPageState({
    required this.ToPass,
  });

  @override
  Widget build(BuildContext context) {
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
            title: const Text("Virtual bin"),
            backgroundColor: Colors.transparent,
            actions: const [
              SizedBox(width: 5),
              // IconButton(
              //   icon: Icon(Icons.logout),
              //   onPressed: _logout,
              // ),
            ],
          ),
          body: //Center(
              // child: Text(
              //   "Added to the Virtual bin successfully. ${widget.ToPass} points been added.",
              //   style: const TextStyle(
              //     fontSize: 18, // Adjust the font size as needed
              //     fontWeight: FontWeight.bold, // Add or remove FontWeight as needed
              //     color: Colors.white,
              //   ),
              // ),

              //  ),snapshot.connectionState == ConnectionState.done
              FutureBuilder(
                  future: DataBaseServices().fetchmongo(ToPass),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<dynamic>;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Added Items history",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    data[index].toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Center(
                          child: Text("Error!!! : ${snapshot.error}"),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))),
    );
  }
}
