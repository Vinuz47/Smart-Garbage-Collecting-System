import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/sign_up/components/reusable_widget.dart';

import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
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
        
          reusableTextField3("Email", Icons.phone_android, false, _emailTextController, "Enter your Email"),
          
          const SizedBox(height: 20),
      
          reusableTextField1("Password", Icons.lock_outline, true, _passwordTextController, "Enter your Password"),
          
          const SizedBox(height: 20),
          
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 16),
        
          firebaseUIButton(context, "Sign In", () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>LoginSuccessScreen(username: _emailTextController.text)));
                            
                      }).onError((error, stackTrace) {
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Container(
                            //padding: EdgeInsetsDirectional.all(5),
                            height: 50,
                            width: 20,
                            decoration:const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(190), topRight: Radius.circular(0),bottomLeft: Radius.circular(190))
                            ),
                            child:const Column(children: [
                              Text("Error!",style: TextStyle(fontSize: 15, color: Colors.white,)),
                              //Spacer(),
                              Text("Password is wrong",style: TextStyle(fontSize: 10, color: Colors.white,))
                            ]),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          )
                        );
                        print("Error ${error.toString()}");
                      }
                      );
                    }),
        ],
      ),
    );
  }
}
