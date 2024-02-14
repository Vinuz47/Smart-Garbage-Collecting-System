import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

TextField reusableTextField1(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, String hintText){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 11, 11, 11),
    style: TextStyle(color:const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9)),
    decoration: InputDecoration(
      labelText: text,
      hintText: hintText,
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      //labelText: text,
      labelStyle: TextStyle(color: const Color.fromARGB(255, 18, 18, 18).withOpacity(0.9)),
      filled: true,
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: TextInputType.emailAddress
  );
}

TextField reusableTextField2(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, String hintText){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 11, 11, 11),
    style: TextStyle(color:const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9)),
    decoration: InputDecoration(
      labelText: text,
      hintText: hintText,
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      //labelText: text,
      labelStyle: TextStyle(color: const Color.fromARGB(255, 18, 18, 18).withOpacity(0.9)),
      filled: true,
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: TextInputType.emailAddress
  );
}

TextField reusableTextField3(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, String hintText){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 11, 11, 11),
    style: TextStyle(color:const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9)),
    decoration: InputDecoration(
      labelText: text,
      hintText: hintText,
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      //labelText: text,
      labelStyle: TextStyle(color: const Color.fromARGB(255, 18, 18, 18).withOpacity(0.9)),
      filled: true,
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: TextInputType.emailAddress
  );
}


Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.green;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );}


