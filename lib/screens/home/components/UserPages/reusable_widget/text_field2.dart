import 'package:flutter/material.dart';

class MyTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;

  const MyTextField2({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText,
  required this.icon
  });


  //State<TextField> createState() => _TextFieldState();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      
      obscureText: obscureText,
        decoration: InputDecoration(
        icon: icon,
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 92, 89, 89)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        iconColor: Colors.grey,
        hintStyle: TextStyle(color: Colors.grey[600]),
        fillColor: Colors.grey.shade200,
        filled: true,
        
      ),
      keyboardType: TextInputType.number,
    );
  }
}