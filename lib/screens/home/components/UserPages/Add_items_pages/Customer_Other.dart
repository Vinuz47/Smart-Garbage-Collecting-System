import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Sending_DB.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';

import '../utils/colours.dart';

class AddOther extends StatefulWidget {
  final String ToPass;
  const AddOther({super.key, required this.ToPass});

  @override
  State<AddOther> createState() => _AddOtherState();
}

class _AddOtherState extends State<AddOther> {
  String selectedOption = '';
  bool loading = false; // to show the loading screen
  late String username;
  int points = 0;
  String type = ''; // to input to the history
  final textController = TextEditingController();

  void send_db() async {
    DataBaseServices.insertingdata(username, 'other', points, type);
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
          title: const Text("Other Items"),
          backgroundColor: hexStringToColor("006400"),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Enter Your Item below :'),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Type your item',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            textController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        )),
                  ),
                  const SizedBox(
                    height: 90,
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
                      type = "Other: " + textController.text;
                      points = 60;
                      send_db();
                      textController.clear();
                    },
                    child: const Text("Add to the bin"),
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
