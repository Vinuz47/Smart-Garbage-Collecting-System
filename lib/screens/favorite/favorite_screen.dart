import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/home/components/UserPages/Subpages_Collector/Points_transfer_collector.dart';
import 'package:shop_app/screens/home/components/UserPages/Subpages_Collector/advertisement.dart';
import 'package:shop_app/screens/home/components/UserPages/map/mapsample2.dart';
import 'package:shop_app/screens/home/components/UserPages/pointsview.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = "Kamal";
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Collector Page",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: demoProducts.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => ProductCard(
                  product: demoProducts[index],
                  // onPress: () => Navigator.pushNamed(
                  //   context,
                  //   DetailsScreen.routeName,
                  //   arguments: ProductDetailsArguments(product: demoProducts[index]),
                  onPress: () => {
                    if (index == 0)
                      {Navigator.push(context, MaterialPageRoute(builder: (context) => const MapSample2(latit:  7.8731, longi: 80.7718))),
                      print("map"),
                      }
                    else if (index == 1)
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Advertisement(locationAddress: "", longit: 0.0, latid: 0.0, username: username))),
                            print("Adver"),
                      }
                    else if (index == 2)
                      {Navigator.push(context, MaterialPageRoute(builder: (context) => Points_transfer_collector(ToPass: username))),
                      print("transfer"),
                      }
                    else if (index == 3)
                      {Navigator.push(context, MaterialPageRoute(builder: (context) => PointsView(username: username))),
                      print("points view"),
                      }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
