
import 'package:flutter/material.dart';
import 'progress.dart';
import 'taskList.dart';
import 'button.dart';
import 'todoListScreen.dart';

class MyHomePage extends StatelessWidget {

void navigateToScreen2(BuildContext context) {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => Screen2()),
);
}
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
          ColorChanger(),
          ElevatedButton(
            onPressed: () {
              navigateToScreen2(context); // Use the function to navigate to Screen2
            },
            child: Text('Go to Todos List Screen '),
          ),
          // Screen1(),
        ],
      ),
    );
  }
}
