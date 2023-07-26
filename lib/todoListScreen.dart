import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  // Function to navigate back to Screen1
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos List'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // Center the button vertically
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                navigateBack(
                    context); // Use the function to navigate back to Screen1
              },
              child: Text('Go Back to home page'),
            ),
          ),
        ],
      ),
    );
  }
}
