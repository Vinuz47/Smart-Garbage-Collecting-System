import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/UserPages/Sending_DB.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up/components/reusable_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final List<String?> errors = [];
  final TextEditingController _usernameTextController= TextEditingController();
  final TextEditingController _emailTextController= TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          reusableTextField2("Username", Icons.person_outline, false, _usernameTextController,"Enter your Username"),

          const SizedBox(height: 20),

          reusableTextField3("Email", Icons.phone_android, false, _emailTextController, "Enter your Email"),
          
          const SizedBox(height: 20),

          reusableTextField1("Password", Icons.lock_outline, true, _passwordTextController, "Enter your Password"),
          
          const SizedBox(height: 40),

          firebaseUIButton(context, "Register", () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>const SignInScreen()));
                            DataBaseServices.insertinguser(_emailTextController.text );
                      }).onError((error, stackTrace) {

                        print("Error ${error.toString()}");
                      }
                      );
                    }),
              
          
        ],
      ),
    );
  }
}
