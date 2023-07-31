import 'package:firstapptwo/loginFLow.dart';
import 'package:flutter/material.dart';
import 'myHomePage.dart';
import 'package:firstapptwo/todoListScreen.dart';

void main() {
  runApp(MyApp()); // First class to run
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Check it out",
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
      '/': (context)=>LoginFlow(),
        // '/': (context) => MyHomePage(), // Define route for MyHomePage
        '/todos': (context) => TodosScreen()
         // Define route for TodosScreen
      },
    );
  }
}






