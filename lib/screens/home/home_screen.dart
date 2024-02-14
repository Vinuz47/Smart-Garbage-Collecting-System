import 'package:flutter/material.dart';

import 'components/discount_banner.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              // HomeHeader(),
              SpecialOffers(),
              SizedBox(height: 20),
              DiscountBanner(
                message: "Learning Page",
                path: "A",
              ),
              DiscountBanner(message: "Locations", path: "B"),
              DiscountBanner(message: "Wall", path: "C"),
              // Categories(),
              PopularProducts(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
