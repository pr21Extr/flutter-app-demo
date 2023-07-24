import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  final String label;

  const TaskItem({Key? key, required this.label}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          value: isChecked,
        ),
        Text(widget.label),
      ],
    );
  }
}
