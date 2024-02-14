import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:shop_app/screens/home/components/UserPages/Sending_DB.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';

import '../utils/colours.dart';

class AddBottles extends StatefulWidget {
  final String username;
  const AddBottles({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<AddBottles> createState() => _AddBottlesState(username: username);
}

class _AddBottlesState extends State<AddBottles> {
  String username;
  _AddBottlesState({
    required this.username,
  });
  List<String> list1 = ['100ml', '250ml', '500ml'];
  List<String> list2 = ['750ml', '1.5L', '2L'];
  //List<String> list3 = ['500g', '2L'];
  var x = 5;
  var y = 5;
  String row_in_toggle = "";
  int total = 0;
  int type = 1;
  var Recycle_type;
  var inputtext;
  String size = "";
  String name = "Gethwan";

  final List<bool> _selectedlist1 = [false, false, false];
  final List<bool> _selectedlist2 = [false, false, false];
  //List<bool> _selectedlist3 = [false, false, false];

  //static mongo.Db? _db;
  bool loading = false; // to show the loading circle when press add to bin

  void _function1(BuildContext context, String rowUsed) async {
    // var db = await mongo.Db.create(MONGO_URL);
    // await db.open();
    // inspect(db);

    //var status = db.serverStatus();
    //var collection = db.collection(COLLECTION_NAME);
    if (rowUsed == "A") {
      if (x == 0) {
        total = type * 5 * int.parse(inputtext);
        size = "100ml";
      } else if (x == 1) {
        total = type * 10 * int.parse(inputtext);
        size = "250ml";
      } else if (x == 2) {
        total = type * 15 * int.parse(inputtext);
        size = "500ml";
      }
    } else if (rowUsed == "B") {
      if (y == 0) {
        total = type * 20 * int.parse(inputtext);
        size = "750ml";
      } else if (y == 1) {
        total = type * 25 * int.parse(inputtext);
        size = "1.5L";
      } else if (y == 2) {
        total = type * 30 * int.parse(inputtext);
        size = "2L";
      }
    }

    var text = int.parse(inputtext);

    // print("Recycle type : $Recycle_type  Total value : $total  Amount : $inputtext value of input text: $text type : $type");
    // print("size : $size  X value: $x  Y value: $y  toggle_row: $row_in_toggle");
    DataBaseServices.insertingdata(username, Recycle_type, total, '$inputtext $Recycle_type $size');
    // await collection.update(mongo.where.eq('username', username), mongo.modify.inc(Recycle_type, total));
    // await collection.update(mongo.where.eq('username', username), mongo.modify.push('items', '$inputtext $Recycle_type $size'));
    // // Navigator.push( .push('items', '$inputtext $Recycle_type $size')
    //   context,
    //   MaterialPageRoute(builder: (contex) => TestPage()),
    // );

    setState(() {
      loading = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You have earned $total number of points"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage(ToPass: total)));
  }

  final _textController = TextEditingController();

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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          appBar: AppBar(
            title: const Text("Bottles and cans"),
            backgroundColor: Colors.transparent,
            actions: const [
              SizedBox(width: 5),
              // IconButton(
              //   icon: Icon(Icons.logout),
              //   onPressed: _logout,
              // ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Text("Plastic")),
                Tab(icon: Text("Glass")),
                Tab(icon: Text("Tin")),
              ],
            ),
          ),
          body: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ToggleButtons(
                              direction: Axis.horizontal, // Adjust as needed
                              onPressed: (int index) {
                                setState(() {
                                  // Update the selected options when a button is tapped
                                  for (int i = 0; i < _selectedlist1.length; i++) {
                                    //_selectedlist1[i] = i == index;
                                    print("i value : $i");
                                    if (i == index) {
                                      _selectedlist1[i] = !_selectedlist1[i]; // Toggle the selected state
                                      //_selectedlist2[x] = false;
                                      x = index;
                                      row_in_toggle = "A";
                                      Recycle_type = "plastic";
                                      print("pressed x: $x");
                                      type = 10;
                                      for (int k = 0; k < _selectedlist2.length; k++) {
                                        _selectedlist2[k] = false;
                                      }
                                    } else {
                                      _selectedlist1[i] = false; // Deselect other options
                                    }
                                  }
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 80, 212, 239),
                              color: const Color.fromARGB(255, 80, 212, 239),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedlist1,
                              children: list1.map((list1) {
                                return Text(
                                  list1,
                                  style: const TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ToggleButtons(
                              direction: Axis.horizontal, // Adjust as needed
                              onPressed: (int index) {
                                setState(() {
                                  // Update the selected options when a button is tapped
                                  for (int i = 0; i < _selectedlist2.length; i++) {
                                    //_selectedlist1[i] = i == index;

                                    if (i == index) {
                                      _selectedlist2[i] = !_selectedlist2[i]; // Toggle the selected state
                                      // _selectedlist1[x] = false;
                                      y = index;
                                      Recycle_type = "plastic";
                                      print("pressed y: $y");
                                      type = 10;
                                      row_in_toggle = "B";
                                      for (int k = 0; k < _selectedlist2.length; k++) {
                                        _selectedlist1[k] = false;
                                      }
                                    } else {
                                      _selectedlist2[i] = false; // Deselect other options
                                    }
                                  }
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 80, 212, 239),
                              color: const Color.fromARGB(255, 80, 212, 239),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedlist2,
                              children: list2.map((list2) {
                                return Text(
                                  list2,
                                  style: const TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            )),
                        Container(
                          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: _textController,
                                decoration: InputDecoration(
                                  hintText: 'How many bottles',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _textController.clear();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                                ),
                                onPressed: () {
                                  inputtext = _textController.text;
                                  setState(() {
                                    loading = true;
                                  });

                                  _function1(context, row_in_toggle);
                                },
                                child: const Text("Add to the bin"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Glass items
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ToggleButtons(
                              direction: Axis.horizontal, // Adjust as needed
                              onPressed: (int index) {
                                setState(() {
                                  // Update the selected options when a button is tapped
                                  for (int i = 0; i < _selectedlist1.length; i++) {
                                    //_selectedlist1[i] = i == index;
                                    print("i value : $i");
                                    if (i == index) {
                                      _selectedlist1[i] = !_selectedlist1[i]; // Toggle the selected state
                                      //_selectedlist2[x] = false;
                                      x = index;
                                      row_in_toggle = "A";
                                      Recycle_type = "Glass";
                                      print("pressed x: $x");
                                      type = 20;
                                      for (int k = 0; k < _selectedlist2.length; k++) {
                                        _selectedlist2[k] = false;
                                      }
                                    } else {
                                      _selectedlist1[i] = false; // Deselect other options
                                    }
                                  }
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 80, 212, 239),
                              color: const Color.fromARGB(255, 80, 212, 239),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedlist1,
                              children: list1.map((list1) {
                                return Text(
                                  list1,
                                  style: const TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ToggleButtons(
                              direction: Axis.horizontal, // Adjust as needed
                              onPressed: (int index) {
                                setState(() {
                                  // Update the selected options when a button is tapped
                                  for (int i = 0; i < _selectedlist2.length; i++) {
                                    //_selectedlist1[i] = i == index;

                                    if (i == index) {
                                      _selectedlist2[i] = !_selectedlist2[i]; // Toggle the selected state
                                      // _selectedlist1[x] = false;
                                      y = index;
                                      Recycle_type = "Glass";
                                      print("pressed y: $y");
                                      type = 20;
                                      row_in_toggle = "B";
                                      for (int k = 0; k < _selectedlist2.length; k++) {
                                        _selectedlist1[k] = false;
                                      }
                                    } else {
                                      _selectedlist2[i] = false; // Deselect other options
                                    }
                                  }
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 80, 212, 239),
                              color: const Color.fromARGB(255, 80, 212, 239),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedlist2,
                              children: list2.map((list2) {
                                return Text(
                                  list2,
                                  style: const TextStyle(color: Colors.white),
                                );
                                ;
                              }).toList(),
                            )),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: <Widget>[
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SizedBox(height: 10),
                        //         ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        //           ),
                        //           onPressed: null,
                        //           child: Text('100g'),
                        //         ),
                        //         SizedBox(height: 10),
                        //         ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        //           ),
                        //           onPressed: null,
                        //           child: Text('750g'),
                        //         ),
                        //       ],
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SizedBox(height: 10),
                        //         ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        //           ),
                        //           onPressed: null,
                        //           child: Text('250g'),
                        //         ),
                        //         SizedBox(height: 10),
                        //         ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        //           ),
                        //           onPressed: null,
                        //           child: Text('1.5L'),
                        //         ),
                        //       ],
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SizedBox(height: 10),
                        //         ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        //           ),
                        //           onPressed: null,
                        //           child: Text('500g'),
                        //         ),
                        //         SizedBox(height: 10),
                        //         ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        //           ),
                        //           onPressed: null,
                        //           child: Text('2L'),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        Container(
                          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: _textController,
                                decoration: InputDecoration(
                                  hintText: 'How many bottles',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _textController.clear();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                                ),
                                onPressed: () {
                                  inputtext = _textController.text;
                                  setState(() {
                                    loading = true;
                                  });

                                  _function1(context, row_in_toggle);
                                },
                                child: const Text("Add to the bin"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ToggleButtons(
                              direction: Axis.horizontal, // Adjust as needed
                              onPressed: (int index) {
                                setState(() {
                                  // Update the selected options when a button is tapped
                                  for (int i = 0; i < _selectedlist1.length; i++) {
                                    //_selectedlist1[i] = i == index;
                                    print("i value : $i");
                                    if (i == index) {
                                      _selectedlist1[i] = !_selectedlist1[i]; // Toggle the selected state
                                      //_selectedlist2[x] = false;
                                      x = index;
                                      row_in_toggle = "A";
                                      Recycle_type = "Tin";
                                      print("pressed x: $x");
                                      type = 30;
                                      for (int k = 0; k < _selectedlist2.length; k++) {
                                        _selectedlist2[k] = false;
                                      }
                                    } else {
                                      _selectedlist1[i] = false; // Deselect other options
                                    }
                                  }
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 80, 212, 239),
                              color: const Color.fromARGB(255, 80, 212, 239),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedlist1,
                              children: list1.map((list1) {
                                return Text(
                                  list1,
                                  style: const TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ToggleButtons(
                              direction: Axis.horizontal, // Adjust as needed
                              onPressed: (int index) {
                                setState(() {
                                  // Update the selected options when a button is tapped
                                  for (int i = 0; i < _selectedlist2.length; i++) {
                                    //_selectedlist1[i] = i == index;

                                    if (i == index) {
                                      _selectedlist2[i] = !_selectedlist2[i]; // Toggle the selected state
                                      // _selectedlist1[x] = false;
                                      y = index;
                                      Recycle_type = "Tin";
                                      print("pressed y: $y");
                                      type = 30;
                                      row_in_toggle = "B";
                                      for (int k = 0; k < _selectedlist2.length; k++) {
                                        _selectedlist1[k] = false;
                                      }
                                    } else {
                                      _selectedlist2[i] = false; // Deselect other options
                                    }
                                  }
                                });
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: Colors.blue[700],
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 80, 212, 239),
                              color: const Color.fromARGB(255, 80, 212, 239),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedlist2,
                              children: list2.map((list2) {
                                return Text(
                                  list2,
                                  style: const TextStyle(color: Colors.white),
                                );
                                ;
                              }).toList(),
                            )),
                        Container(
                          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: _textController,
                                decoration: InputDecoration(
                                  hintText: 'How many bottles',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _textController.clear();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                                ),
                                onPressed: () {
                                  inputtext = _textController.text;
                                  setState(() {
                                    loading = true;
                                  });

                                  _function1(context, row_in_toggle);
                                },
                                child: const Text("Add to the bin"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                // BottomNavigationBarItem(
                //     icon: Icon(Icons.home),
                //     label: 'Home',
                //     backgroundColor: Colors.green),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search', backgroundColor: Colors.yellow),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Virtual Bin',
                  backgroundColor: Colors.blue,
                ),
              ],
              onTap: (int index) {
                if (index == 0) {
                } else if (index == 1) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage(ToPass: username)));
                }
              }),
        ),
      ),
    );
  }
}

class ElevatedButtonExample extends StatefulWidget {
  const ElevatedButtonExample({super.key});

  @override
  State<ElevatedButtonExample> createState() => _ElevatedButtonExampleState();
}

class _ElevatedButtonExampleState extends State<ElevatedButtonExample> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10),
          ElevatedButton(
            style: style,
            onPressed: () {},
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }
}
