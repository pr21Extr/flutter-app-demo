import 'package:flutter/material.dart';
import 'taskItem.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Column(
      children: [
        TaskItem(label: "Task 1"),
        TaskItem(label: "Task 2"),
        TaskItem(label: "Task 3"),
        TaskItem(label: "Task 4"),
        Expanded(
          child: Container(
            // color: Colors.amber, used Expanded but I dont think its the correct implementation
            width: 10,

          ),

        )
      ],
      ),
    );
  }
}
