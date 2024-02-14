import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Learning_page.dart';
import 'package:shop_app/screens/home/components/UserPages/display_wall.dart';
import 'package:shop_app/screens/home/components/UserPages/map/mapsample2.dart';

class DiscountBanner extends StatelessWidget {
  final String message;
  final String path;
  const DiscountBanner({Key? key, required this.message, required this.path}) : super(key: key);

  void ChoosePage(BuildContext context, String letter) {
    if (letter == "A") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LearnPage(username: "Gethwan")));
    } else if (letter == "B") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MapSample2(latit: 0, longi: 0)));
    } else if (letter == "C") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MongoDbDisplay()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          ChoosePage(context, path);
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 70, 204, 115),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text.rich(
            TextSpan(
              style: const TextStyle(color: Colors.white),
              children: [
                const TextSpan(text: "A Summer Surpise\n"),
                TextSpan(
                  text: message,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
