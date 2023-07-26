import 'package:flutter/material.dart';
import 'myHomePage.dart';
import 'package:firstapptwo/todoListScreen.dart';

void main() {
  runApp(

    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          15,
              (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ),
      ),
    ),
  );
}


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






