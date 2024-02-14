//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  //final Geolocation location;
  const Comment({super.key,
  required this.text,
  required this.user,
  required this.time,
  //required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          //comment
          Text(text),

          //user , time
          Row(
            children: [
              Text(user),
              const Text(" . "),
              Text(time),
            ],
          ),

        ],
      ),
    );
  }
}