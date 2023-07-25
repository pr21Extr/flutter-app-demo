import 'package:flutter/material.dart';
import 'progress.dart';
import 'taskList.dart';
import 'button.dart';

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
          ColorChanger(),
        ],
      ),
    );
  }
}
