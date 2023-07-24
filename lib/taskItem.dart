import 'package:flutter/material.dart';

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
