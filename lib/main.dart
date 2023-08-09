import 'package:firstapptwo/firestoreData.dart';
import 'package:firstapptwo/loginFLow.dart';
import 'package:firstapptwo/otpLogin.dart';
import 'package:firstapptwo/staggeredGrid.dart';
import 'package:flutter/material.dart';
import 'myHomePage.dart';
import 'package:firstapptwo/todoListScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );
  runApp(MyApp()); // First class to run
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Check it out",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        'MyHomePage': (context) => MyHomePage(), // Define route for MyHomePage
        // '/': (context)=>LoginFlow(),
        // '/': (context)=>StaggeredGridViewExample(),
        // '/': (context)=>LoginWithPhone(),
        '/': (context)=>FireWrite(),


        '/todos': (context) => TodosScreen()
         // Define route for TodosScreen
      },
    );
  }
}






