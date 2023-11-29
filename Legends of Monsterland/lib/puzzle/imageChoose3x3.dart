import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/themeSettings.dart';

import '3x3puzzle.dart';

class imageChoose3x3 extends StatefulWidget {

  @override
  State<imageChoose3x3> createState() => _imageChoose3x3State();
}

class _imageChoose3x3State extends State<imageChoose3x3> {

  late int energy;
  late int candy;

  final player = AudioPlayer();

  void loadData() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      candy = data['candy'];
      energy = data['energy'];
    });
  }

  void decreaseEnergy() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newEnergy = energy - 1;
    if (newEnergy >= 0) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'energy': newEnergy});

      setState(() {
        energy = newEnergy;
      });
    }
  }

  @override
  void initState() {
    player.play(AssetSource('sounds/puzzleback.mp3'), volume: 0.5);
    player.setReleaseMode(ReleaseMode.loop);
    loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool?> dontEnergy(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text('error'.tr),
          content: Text('outofenergy'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('watchadsforenergy'.tr),
              onPressed: () {
              },
            ),
            TextButton(
              child: Text('okay'.tr),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('chooseimage'.tr, style: baslikStili,),
          centerTitle: true,
          backgroundColor: Colors.teal[400],
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(16),
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                player.stop();
                if(energy<=0){
                  dontEnergy(context);
                  print('enerjiyok');
                }else{
                  decreaseEnergy();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => puzzle3x3(imageChoose: index)));
                }
              },
              child: Container(
                color: Colors.teal[100],
                child: Image.asset('assets/puzzleGame/imageChoose3x3/0$index.png'),
              ),
            );
          },
        ),
      ),
    );
  }
}

