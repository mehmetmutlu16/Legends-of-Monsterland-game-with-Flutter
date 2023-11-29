import 'package:flutter/material.dart';

class clickToStart extends StatelessWidget {

  final bool hasStarted;

  clickToStart({required this.hasStarted});


  @override
  Widget build(BuildContext context) {
    return hasStarted
        ? Container()
        : Stack(
      children: [
        Container(
          alignment: const Alignment(0, -0.7),
          child: const Text('Dino Skate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
