import 'package:flutter/material.dart';

class barrier extends StatelessWidget{

  final double barrierX;
  final double barrierY;
  final double barrierWidth;
  final double barrierHeight;

  barrier({
    required this.barrierX,
    required this.barrierY,
    required this.barrierWidth,
    required this.barrierHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          (2* barrierY+ barrierHeight) / (2 - barrierHeight)), // Alignment
      child: Container(
        height: MediaQuery.of(context).size.height * 2 / 3* barrierHeight / 2,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        child: Image.asset(
          'assets/skate/barrier.png',
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
        ),// Image.asset
      ), // Container
    ); // Container
  }
}