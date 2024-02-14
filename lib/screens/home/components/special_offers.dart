import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Add_items_pages/Customer_Other.dart';
import 'package:shop_app/screens/home/components/UserPages/Add_items_pages/Customer_bottles.dart';
import 'package:shop_app/screens/home/components/UserPages/Add_items_pages/Customer_electronics.dart';
import 'package:shop_app/screens/home/components/UserPages/Add_items_pages/Customer_paper.dart';

import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Add Items",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Plastic_Bottles.png",
                category: "Bottles and cans",
                // numOfBrands: 18,
                press: () {
                  //Navigator.pushNamed(context, ProductsScreen.routeName);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddBottles(username: "Gethwan")));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/Paper.png",
                category: "Paper and Cardboard",
                // numOfBrands: 24,
                press: () {
                  //Navigator.pushNamed(context, ProductsScreen.routeName);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const Addpaper(ToPass: "Gethwan")));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/Electronics.png",
                category: "Electronics",
                // numOfBrands: 24,
                press: () {
                  //Navigator.pushNamed(context, ProductsScreen.routeName);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const Addelectronics(ToPass: "Gethwan")));
                },
              ),
              SpecialOfferCard(
                image: "assets/images/Other.png",
                category: "Other",
                // numOfBrands: 24,
                press: () {
                  //Navigator.pushNamed(context, ProductsScreen.routeName);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddOther(ToPass: "Gethwan")));
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    //required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  //final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
