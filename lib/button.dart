import 'package:flutter/material.dart';
// class ElevatedButtonWidget extends StatefulWidget {
//   const ElevatedButtonWidget({super.key});
//
//   @override
//   State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
// }
//
// class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final ButtonStyle style =
//     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
//
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//
//           ElevatedButton(
//             style: style,
//             onPressed: () {
//               // changeBackgroundColor();
//             },
//             child: const Text('Click Me',
//             style:TextStyle()),
//
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//

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
              'Click Me',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
