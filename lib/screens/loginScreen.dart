import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_app/authentication.dart';
import 'package:provider/provider.dart';

String error;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _signUp(String email, String password, BuildContext context) async {
    Authentication _user = Provider.of<Authentication>(context, listen: false);

    try {
      if (await _user.signUpUser(email, password, context)) {
        Navigator.popAndPushNamed(context, 'home');
      }
    } catch (e) {
      print(e);
    }
  }

  void _login(String email, String password, BuildContext context) async {
    Authentication _user = Provider.of<Authentication>(context, listen: false);

    try {
      if (await _user.loginUser(email, password, context)) {
        Navigator.popAndPushNamed(context, 'home');
      }
    } catch (e) {
      print(e);
    }
  }

  String validatePass(value) {
    if (value.isEmpty) {
      return 'Required';
    } else if (value.length < 6) {
      return 'Should be more than 6 characters';
    } else if (value.length > 12) {
      return 'Should not be more than 12 characters';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: Text(
                        'Hello,\n',
                        style: TextStyle(
                            letterSpacing: 3,
                            fontSize: 35,
                            color: Color(0xFF495464),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                validator: MultiValidator([
                                  EmailValidator(
                                      errorText: 'Enter a valid E-mail'),
                                  RequiredValidator(errorText: 'Required')
                                ]),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                controller: password,
                                validator: validatePass,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password'),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: RaisedButton(
                          child: Text('Sign up'),
                          onPressed: () {
                            _signUp(email.text, password.text, context);
                            if (error != null) {
                              Scaffold.of(context)
                                  .showSnackBar(SnackBar(content: Text(error)));
                              setState(() {
                                error = null;
                              });
                            }
                          }),
                    ),
                    Center(
                      child: RaisedButton(
                          child: Text('Log In'),
                          onPressed: () {
                            _login(email.text, password.text, context);
                            if (error != null) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(error),
                                duration: Duration(seconds: 2),
                              ));
                              setState(() {
                                error = null;
                              });
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
