import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Staggered Grid '),
          backgroundColor: Colors.pinkAccent,
        ),
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.cyan,
              child: Center(
                child: Text('Tile $index'),
              ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,  // Space between rows
          crossAxisSpacing: 4.0, // Space between columns
        ),
      ),
    );
  }
}

