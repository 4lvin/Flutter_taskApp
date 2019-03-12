import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_task/src/auth/auth.dart';
import 'package:plan_task/src/ui/login.dart';
import 'package:plan_task/src/ui/task_list.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RootPage extends StatefulWidget {
 RootPage({this.firebaseUser});
   FirebaseUser firebaseUser;
  @override
  _RootPageState createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  GoogleSignIn googleSignIn;
  @override
  void initState() {
    super.initState();
    if(widget.firebaseUser == null) {
      getSignedInAccount().then((userId) {
        setState(() {
          authStatus =
          userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
          print(userId);
          widget.firebaseUser = userId;
        });
      }).catchError((onError) {
        authStatus = AuthStatus.notSignedIn;
      });
    }
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
          authStatus = AuthStatus.notSignedIn;
        });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.firebaseUser == null){
      return new LoginPage(onSignIn: _signedIn);
    }else{
      return new TaskList(user:widget.firebaseUser,googleSignIn: googleSignIn, signOut: _signedOut);
    }
//    switch (authStatus) {
//      case AuthStatus.notSignedIn:
//        return new LoginPage(onSignIn: _signedIn);
//      case AuthStatus.signedIn:
//      return new TaskList(user:widget.firebaseUser,googleSignIn: googleSignIn, signOut: _signedOut);
//    }
  }
}