import 'package:flutter/material.dart';
import 'taskItem.dart';

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
