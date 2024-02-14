import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Sending_DB.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';

import '../utils/colours.dart';

class Successful_transfer extends StatefulWidget {
  final String ToPass;
  final String collector_name;
  const Successful_transfer({super.key, required this.ToPass, required this.collector_name});

  @override
  State<Successful_transfer> createState() => _Successful_transferState();
}

class _Successful_transferState extends State<Successful_transfer> {
  String selectedOption = '';
  bool loading = false; // to show the loading screen
  late String details;
  late String collectorname;
  String username = " ";
  int points = 1;
  String type = ''; // to input to the history
  final textController = TextEditingController();
  bool _initialized = false; // Flag to check if initialization has been done

  void separate_string(String details) {
    List<String> parts = details.split(',');

    if (parts.length == 2) {
      username = parts[0];
      points = int.parse(parts[1]);

      print("usernameName: $username");
      print("Points: $points");
    } else {
      print("Invalid data format");
    }
  }

  void send_db() async {
    setState(() {
      loading = true;
    });
    DataBaseServices.insertingPoints(collectorname, points);
    await Future.delayed(const Duration(milliseconds: 100));
    DataBaseServices.after_point_transfer(username);
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
    if (!_initialized) {
      details = widget.ToPass;
      collectorname = widget.collector_name;
      separate_string(details);
      send_db();
      _initialized = true; // Set the flag to true after initialization
    }
  }

  // @override
  // void didUpdateWidget(covariant Successful_transfer oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // Compare oldWidget with widget and perform actions accordingly
  //   if (widget.ToPass != oldWidget.ToPass) {
  //     details = widget.ToPass;
  //     separate_string(details);
  //     send_db();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("sucessful page"),
          backgroundColor: hexStringToColor("006400"),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sucessfuly added $points to your account.'),
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
                    .push(MaterialPageRoute(builder: (context) => TestPage(ToPass: collectorname))); // ToPass variable a dummy value is passed
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
