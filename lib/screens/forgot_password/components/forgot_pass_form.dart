import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_up/components/reusable_widget.dart';

import '../../../components/no_account_text.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          reusableTextField3("Email", Icons.phone_android, false, _emailTextController, "Enter your email"),
          const SizedBox(height: 8),
          
          const SizedBox(height: 8),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       // Do what you want to do
          //     }
          //   },
          //   child: const Text("Continue"),
          // ),
          firebaseUIButton(context, "Reset Password", () {
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailTextController.text)
                  .then((value) => Navigator.of(context).pop());
                // Navigator.push(context,
                //             MaterialPageRoute(builder: (context)=>const SignInScreen()));
                    }),
          const SizedBox(height: 16),
          const NoAccountText(),
        ],
      ),
    );
  }
}
