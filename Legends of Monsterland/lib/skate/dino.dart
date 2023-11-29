import 'package:flutter/material.dart';

class dino extends StatelessWidget {

  final double dinoX;
  final double dinoY;
  final double dinoWidth;
  final double dinoHeight;

  dino ({
    required this.dinoX,
    required this.dinoY,
    required this.dinoWidth,
    required this.dinoHeight,
  });


  @override
  Widget build (BuildContext context) {
    return Container (
      alignment: Alignment ((2 * dinoX + dinoWidth) / (2 - dinoWidth),
          (2* dinoY + dinoHeight) / (2 - dinoHeight)), // Alignment
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
        ),
        height: MediaQuery.of (context).size.height *2 / 3* dinoHeight / 2,
        width: MediaQuery.of (context).size.width * dinoWidth / 2,
        child: Image.asset('assets/skate/dino.png',
        ), // Image.asset
      ), // Container
    ); // Container
  }
}