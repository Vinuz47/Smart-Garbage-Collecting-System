import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final String name;
  final IconData icon;
  final Function function;
  const CustomButton({super.key, required this.name, required this.icon, required this.function});

  @override
  State<CustomButton> createState() => _CustomButtonState(name: name, icon: icon, function: function);
}

class _CustomButtonState extends State<CustomButton> {
  final String name;
  final IconData icon;
  final Function function;

  _CustomButtonState({required this.name, required this.icon, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
        // MaterialApp(
        // home: Scaffold(

        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: InkWell(
          onTap: () => function(),
          child: Container(
            //height: 50.0,
            //width: 150.0,
            decoration: BoxDecoration(
                boxShadow: const [BoxShadow(offset: Offset(0.0, 20.0), blurRadius: 2.0, color: Colors.black12)],
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0)),
            child: Row(children: <Widget>[
              Container(
                height: 60.0,
                width: 230.0,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 43, 128),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90.0), topLeft: Radius.circular(90.0), bottomRight: Radius.circular(200.0))),
                child: Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Icon(
                icon,
                size: 30.0,
              )
            ]),
          ),
        ),
      ),
    ));
    // )
    // );
  }
}
