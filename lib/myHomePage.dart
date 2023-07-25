
import 'package:flutter/material.dart';
import 'progress.dart';
import 'taskList.dart';
import 'button.dart';

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
            child: Text('Go to Screen 2'),
          ),
          // Screen1(),
        ],
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  // Function to navigate back to Screen1
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              navigateBack(
                  context); // Use the function to navigate back to Screen1
            },
            child: Text('Go Back to Screen 1'),
          ),
        ],
      ),
    );
  }
}