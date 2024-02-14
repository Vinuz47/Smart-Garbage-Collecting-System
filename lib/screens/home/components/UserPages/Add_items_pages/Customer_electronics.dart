import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Sending_DB.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';

import '../utils/colours.dart';

class Addelectronics extends StatefulWidget {
  final String ToPass;
  const Addelectronics({super.key, required this.ToPass});

  @override
  State<Addelectronics> createState() => _AddelectronicsState();
}

class _AddelectronicsState extends State<Addelectronics> {
  String selectedOption = '';
  bool loading = false; // to show the loading screen
  late String username;
  int points = 0;
  String type = ''; // to input to the history

  void send_db() async {
    DataBaseServices.insertingdata(username, 'electronic', points, type);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      loading = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You have earned $points number of points"),
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
    selectedOption = '';
  }

  @override
  void initState() {
    super.initState();
    username = widget.ToPass;
  }

  String selected_item = 'Mobile Phone';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Paper & Cardboard"),
          backgroundColor: hexStringToColor("006400"),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text("Select your Item from below ")),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    onPressed: () => showCupertinoModalPopup(
                        context: context,
                        builder: (_) => SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: CupertinoPicker(
                              backgroundColor: Colors.white,
                              itemExtent: 30,
                              scrollController: FixedExtentScrollController(
                                initialItem: 0,
                              ),
                              children: const [Text('Mobile Phone'), Text('Monitor'), Text('Computer parts'), Text('Microwave'), Text('Iron')],
                              onSelectedItemChanged: (int value) {
                                setState(() {
                                  switch (value) {
                                    case 0:
                                      {
                                        selected_item = 'Mobile Phone';
                                        points = 100;
                                        type = selected_item;
                                        break;
                                      }
                                    case 1:
                                      {
                                        selected_item = 'Monitor';
                                        points = 200;
                                        type = selected_item;
                                        break;
                                      }
                                    case 2:
                                      {
                                        selected_item = 'Computer parts';
                                        points = 150;
                                        type = selected_item;
                                        break;
                                      }
                                    case 3:
                                      {
                                        selected_item = 'Microwave';
                                        points = 400;
                                        type = selected_item;
                                        break;
                                      }
                                    case 4:
                                      {
                                        selected_item = 'Iron';
                                        points = 300;
                                        type = selected_item;
                                        break;
                                      }
                                  }
                                });
                              },
                            ))),
                    color: Colors.green,
                    child: Text(selected_item),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      send_db();
                    },
                    child: const Text("Add to the bin"),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TestPage(ToPass: username))); // ToPass variable a dummy value is passed
              }
            }));
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            const SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? hexStringToColor("006400") : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
