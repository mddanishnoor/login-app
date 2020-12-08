import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/authentication.dart';
import 'package:login_app/screens/loginScreen.dart';
import 'package:provider/provider.dart';

User loggedInUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut(BuildContext context) {
    Authentication _user = Provider.of<Authentication>(context, listen: false);

    _user.signOut(context);
    Navigator.popAndPushNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF495464), Color(0xFFf4f4f2)])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                ),
                child: Text(
                  'Welcome to your profile !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      wordSpacing: 3,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    child: Text('Sign out'),
                    onPressed: () {
                      error = null;
                      signOut(context);
                    },
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
