import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class StaggeredGridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Staggered Grid View Example'),
        ),
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 4, // Number of columns
          itemCount: 20,     // Total number of items
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.blue,
              child: Center(
                child: Text('Item $index'),
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

