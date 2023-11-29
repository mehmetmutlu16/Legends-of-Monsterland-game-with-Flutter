import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameHasOver extends StatefulWidget {

  bool gamehasOver;

  GameHasOver({required this.gamehasOver});

  @override
  State<GameHasOver> createState() => _GameHasOverState();
}

class _GameHasOverState extends State<GameHasOver> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.gamehasOver
        ? Stack(
      children: [
        Align(
          alignment: Alignment(0,-0.75),
          child: Text('gameover'.tr, style: TextStyle(color: Colors.white, fontSize: 40),)
        ),
      ],
    ) // Stack
        : Container();
  }
}