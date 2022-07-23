import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/loading.dart';
import 'package:myapp/signin.dart';
import 'package:myapp/auth_page.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _pswdController = TextEditingController();
  final _cpswdController = TextEditingController();

  Future create() async {
    if ((_cpswdController.text == _pswdController.text) &&
        (_emailController.text != "" ||
            _cpswdController.text != "" ||
            _pswdController.text != "")) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingPage(),
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _pswdController.text);

      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AuthPage()));

    } else {
      // return a snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Passwords don't match or you didn't fill in all fields"),
      ));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pswdController.dispose();
    _cpswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[800],
          title: Text("Create Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )),
          centerTitle: true,
        ),
        backgroundColor: Colors.brown[50],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined,
                  color: Colors.purple[400], size: 90),
              SizedBox(height: 20),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _pswdController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Password',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _cpswdController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Confirm Password',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple[800], // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  create();

                },
                child: Text('Sign Up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  TextButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
