import 'package:flutter/material.dart';
import 'myHomePage.dart';

void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      title:"Çheckit out ",
      theme: ThemeData.dark(),
      home:MyHomePage()
    );
  }
}






