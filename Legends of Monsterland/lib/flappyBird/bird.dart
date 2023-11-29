import 'package:flutter/material.dart';

class myBird extends StatelessWidget {

  final birdY;
  final double birdWidht;
  final double birdHeight;

  myBird({this.birdY, required this.birdHeight, required this.birdWidht});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2*birdY + birdHeight) / (2-birdHeight)),
      child: Image.asset(
        'assets/flappyBird/bird.png',
        width: MediaQuery.of(context).size.height * birdWidht /1.2,
        height: MediaQuery.of(context).size.height * 3/4 *birdHeight/1.2,
        fit: BoxFit.fill,
      ),
    );
  }
}
