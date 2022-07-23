import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/signin.dart';
import 'package:myapp/auth_page.dart';


class Choice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AuthPage();
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Something went wrong",
                        style: TextStyle(color: Colors.black)));
              } else {
                return SignIn();
              }
            }));
  }
}
