import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plan_task/src/auth/auth.dart';
import 'package:plan_task/src/auth/root_page.dart';
import 'package:plan_task/src/ui/task_list.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignIn});
  final VoidCallback onSignIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    await signIntoFirebase(googleSignInAccount);
    widget.onSignIn();
    Navigator.pushReplacementNamed(context, '/rootpage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
            ),
            new InkWell(
                onTap: () {
                  _signIn();
                },
                child: new Image.asset(
                  'img/googleplussignin.png',
                  width: 300.0,
                )),
          ],
        ),
      ),
    );
  }
}
