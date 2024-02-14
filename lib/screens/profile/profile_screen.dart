import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Virtualbin.dart';
import 'package:shop_app/screens/home/components/UserPages/pointsview.dart';

import 'components/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            //const ProfilePic(),
            // const SizedBox(height: 20),
            ProfileMenu(
              text: "My Virtual Bin",
              icon: "assets/icons/User Icon.svg",
              press: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => const TestPage(ToPass: "Gethwan")))},
            ),
            ProfileMenu(
              text: "Points",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PointsView(username: "Gethwan")));
              },
            ),
            // ProfileMenu(
            //   text: "Settings",
            //   icon: "assets/icons/Settings.svg",
            //   press: () {},
            // ),
            // ProfileMenu(
            //   text: "Help Center",
            //   icon: "assets/icons/Question mark.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
