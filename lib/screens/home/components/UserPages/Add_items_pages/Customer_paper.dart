import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Sending_DB.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';

import '../utils/colours.dart';

class Addpaper extends StatefulWidget {
  final String ToPass;
  const Addpaper({super.key, required this.ToPass});

  @override
  State<Addpaper> createState() => _AddpaperState();
}

class _AddpaperState extends State<Addpaper> {
  String selectedOption = '';
  bool loading = false; // to show the loading screen
  late String username;
  int points = 0;
  String type = ''; // to input to the history

  void send_db() async {
    DataBaseServices.insertingdata(username, 'paper', points, type);
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
                  MyRadioListTile<String>(
                    value: "Light",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      // Handle the change
                      setState(() {
                        selectedOption = value!;
                        print("Selected option: $selectedOption");
                      });
                      points = 10;
                      type = 'paper small amount';
                    },
                    leading: "Light",
                    title: const Text("Weight below 1Kg"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyRadioListTile<String>(
                    value: "Medium",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      // Handle the change
                      setState(() {
                        selectedOption = value!;
                        print("Selected option: $selectedOption");
                      });
                      points = 20;
                      type = 'paper medium amount';
                    },
                    leading: "Medium",
                    title: const Text("Between 1Kg - 5Kg"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyRadioListTile<String>(
                    value: "Heavy",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      // Handle the change
                      setState(() {
                        selectedOption = value!;
                        print("Selected option: $selectedOption");
                      });
                      points = 40;
                      type = 'paper heavy amount';
                    },
                    leading: "Heavy",
                    title: const Text("Weight more than 5Kg"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                    child: Column(
                      children: <Widget>[
                        // TextField(
                        //   keyboardType: TextInputType.number,
                        //   controller: _textController,
                        //   decoration: InputDecoration(
                        //     hintText: 'How many bottles',
                        //     border: const OutlineInputBorder(),
                        //     suffixIcon: IconButton(
                        //       onPressed: () {
                        //         _textController.clear();
                        //       },
                        //       icon: const Icon(Icons.clear),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            //inputtext = _textController.text;
                            setState(() {
                              loading = true;
                              //DataBaseServices.insertingdata(username, 'paper', points, type);
                            });
                            send_db();
                            // _function1(context, row_in_toggle);
                          },
                          child: const Text("Add to the bin"),
                        ),
                      ],
                    ),
                  ),
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
