import 'package:flutter/material.dart';

class Score extends StatelessWidget {

  final score;
  final bestScore;

  Score({this.score,this.bestScore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Score',
                style: const TextStyle(color: Colors.green, fontSize: 25),
              ),
              Text(
                score.toString(),
                style: const TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ],
      ),
    );
  }
}
