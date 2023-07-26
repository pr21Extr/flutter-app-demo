import 'package:flutter/material.dart';


class ColorChanger extends StatefulWidget {
  @override
  _ColorChangerState createState() => _ColorChangerState();
}   //create and manage state

class _ColorChangerState extends State<ColorChanger> {
  bool isBlack = true;    //set default color

  void changeBackgroundColor() {
    setState(() {
      isBlack = !isBlack;   //flip color
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isBlack ? Colors.black : Colors.white;
    TextStyle textStyle = isBlack ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: backgroundColor,
            ),
            onPressed: () {
              changeBackgroundColor();
            },
            child:  Text(
              'Click Me To Change Colors',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
