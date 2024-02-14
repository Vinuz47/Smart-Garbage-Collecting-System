import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shop_app/screens/home/components/UserPages/Subpages_Collector/Sucessful_transfer.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';

import '../utils/colours.dart';

class Points_transfer_collector extends StatefulWidget {
  final String ToPass;
  const Points_transfer_collector({super.key, required this.ToPass});

  @override
  State<Points_transfer_collector> createState() => _Points_transfer_customerState();
}

class _Points_transfer_customerState extends State<Points_transfer_collector> {
  String selectedOption = '';
  bool loading = false; // to show the loading screen
  late String username;
  int points = 0;
  String type = ''; // to input to the history
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String points_details = " ";
  String Not_ava = " ";
  bool sentToSuccessfulPage = false;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void initState() {
    super.initState();
    username = widget.ToPass;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void send_to() {
    if (result != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Successful_transfer(
                  ToPass: points_details,
                  collector_name: username,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Transfer Points"),
          backgroundColor: hexStringToColor("006400"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Expanded(
                  flex:
                      1, //Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')  (result != null) ? _Succesfulpage() : const Text('Scan a code')
                  child: Center(
                    child:
                        (result != null) ? Text('Barcode Type: ${describeEnum(result!.format)}   Data: $points_details') : const Text('Scan a Code'),
                  ))
            ],
          ),
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!sentToSuccessfulPage) {
        setState(() {
          result = scanData;
          points_details = result?.code ?? ' ';
        });
        send_to();
      }
      sentToSuccessfulPage = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
