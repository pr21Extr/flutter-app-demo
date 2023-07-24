import 'package:flutter/material.dart';

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
