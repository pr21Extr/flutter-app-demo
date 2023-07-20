import 'package:flutter/material.dart';

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build (BuildContext context ){
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo app'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Progress(),
          TaskList(),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Column(
      children: [
       const  Text('Lorus ipsum'),
       const  LinearProgressIndicator(value: 0.0,)
      ],
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Column(
      children: [
        TaskItem(label:"Task 1"),
        TaskItem(label:"Task 2"),
        TaskItem(label:"Task 3"),
        TaskItem(label:"Task 4"),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  final String label;

  const TaskItem({Key? key, required this.label}) : super(key: key);


  @override
  Widget build (BuildContext context){
    return Row (
      children: [
        Checkbox( onChanged: null, value: false),
        Text(label),
      ],
    );
  }
}


