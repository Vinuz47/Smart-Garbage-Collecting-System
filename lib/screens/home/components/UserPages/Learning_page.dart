import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'utils/colours.dart';

class LearnPage extends StatefulWidget {
  final String username;
  const LearnPage({
    super.key,
    required this.username,
  });

  @override
  State<LearnPage> createState() => _LearnPageState(username: username);
}

class _LearnPageState extends State<LearnPage> {
  String username;
  _LearnPageState({
    required this.username,
  });
//initialized webview
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://friendsoftheearth.uk/sustainable-living/7-benefits-recycling'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Learning Page"),
          backgroundColor: hexStringToColor("006400"),
        ),
        body: WebViewWidget(controller: controller),
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
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage(ToPass: username))); // ToPass variable a dummy value is passed
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
