import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/authentication.dart';
import 'package:login_app/screens/homeScreen.dart';
import 'package:login_app/screens/loginScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Authentication(),
      child: MaterialApp(
        title: 'Login App',
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          'home': (context) => HomeScreen(),
          'login': (context) => LoginScreen()
        },
      ),
    );
  }
}
