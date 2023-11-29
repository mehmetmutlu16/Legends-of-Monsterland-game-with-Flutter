import 'package:flutter/material.dart';

import 'gridButton.dart';

class grid extends StatelessWidget {
  var numbers = [];
  var size;
  Function clickGrid;
  int imageChoose;

  grid(this.numbers, this.size, this.clickGrid, this.imageChoose);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return Container(
      height: height * 0.60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: 16,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? gridButton("${numbers[index]}", () {
              clickGrid(index);
            },imageChoose)
                : SizedBox.shrink();
          },
        ),
      ),
    );
  }
}