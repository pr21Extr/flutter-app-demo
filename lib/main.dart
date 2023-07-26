import 'package:flutter/material.dart';
import 'myHomePage.dart';

void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      title:"Çheck it out ",
      theme: ThemeData.dark(),
      home:MyHomePage()

    );
  }
}






