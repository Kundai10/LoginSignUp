import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/loading.dart';
import 'package:myapp/register.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // add controllers to so as to keep track of what the user has inputted
  final _pswdControlller = TextEditingController();
  final _emailController = TextEditingController();

  // method for when a user clicks on the sign in button
  // if the email and password fields are not empty the user will be authenticated
  // else a snackbar prompting the user to input something is returned.

  Future click() async {
    if (_emailController.text != "" || _pswdControlller.text != "") {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingPage(),
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _pswdControlller.text);
      Navigator.pop(context);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("All fields are required."),
      ));
    }
  }

  // so as to dispose our controllers when we aren't using them.
  @override
  void dispose() {
    _emailController.dispose();
    _pswdControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined,
                color: Colors.purple[400], size: 90),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("This",
                    style: TextStyle(
                      color: Colors.purple[800],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                Text("App",
                    style: TextStyle(
                      color: Colors.purple[200],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(height: 10),
            Text("Welcome back. Log into your account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
            SizedBox(height: 30),

            // email address text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ' Email Address',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // password textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _pswdControlller,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ' Password',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Sign In Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[800], // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                click();
              },
              child: Text('Sign In'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                TextButton(
                  child: Text("Sign Up."),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                )
              ],
            ),
          ],
        )));
  }
}
