import 'package:flutter/material.dart';
import 'dart:ui';

class gridButton extends StatelessWidget {
  VoidCallback click;
  String text;
  int imageChoose;

  gridButton(this.text, this.click, this.imageChoose);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: resim()),
        ],
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(2)
      ),
      onPressed: click,
    );
  }

  Widget resim(){
    switch(imageChoose){
      case 0:
        if(text=='1'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_001.png', fit: BoxFit.fill,),
          );
        }
        if(text=='2'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_002.png'),
          );
        }
        if(text=='3'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_003.png'),
          );
        }
        if(text=='4'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_004.png'),
          );
        }
        if(text=='5'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_005.png'),
          );
        }
        if(text=='6'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_006.png'),
          );
        }
        if(text=='7'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_007.png'),
          );
        }
        if(text=='8'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_008.png'),
          );
        }if(text=='9'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_009.png'),
          );
        }if(text=='10'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_010.png'),
          );
        }
        if(text=='11'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_011.png'),
          );
        }
        if(text=='12'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_012.png'),
          );
        }
        if(text=='13'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_013.png'),
          );
        }
        if(text=='14'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_014.png'),
          );
        }
        if(text=='15'){
          return Container(
            child: Image.asset('assets/puzzleGame/ant/image_part_015.png'),
          );
        };
        break;
      case 1:
        if(text=='1'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_001.png', fit: BoxFit.fill,),
          );
        }
        if(text=='2'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_002.png'),
          );
        }
        if(text=='3'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_003.png'),
          );
        }
        if(text=='4'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_004.png'),
          );
        }
        if(text=='5'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_005.png'),
          );
        }
        if(text=='6'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_006.png'),
          );
        }
        if(text=='7'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_007.png'),
          );
        }
        if(text=='8'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_008.png'),
          );
        }if(text=='9'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_009.png'),
          );
        }if(text=='10'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_010.png'),
          );
        }
        if(text=='11'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_011.png'),
          );
        }
        if(text=='12'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_012.png'),
          );
        }
        if(text=='13'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_013.png'),
          );
        }
        if(text=='14'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_014.png'),
          );
        }
        if(text=='15'){
          return Container(
            child: Image.asset('assets/puzzleGame/mouse/image_part_015.png'),
          );
        };
        break;

    }


    return Container();
  }
}