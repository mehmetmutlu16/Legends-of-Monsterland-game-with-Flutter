import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/flappyBird/barrier.dart';
import 'package:pokedex/flappyBird/bird.dart';
import 'package:flutter/material.dart';

import '../changePage.dart';

class birdGame extends StatefulWidget {
  const birdGame({Key? key}) : super(key: key);

  @override
  State<birdGame> createState() => _birdGameState();
}

class _birdGameState extends State<birdGame> {
  static double birdY = 0;
  double firstPosition  = birdY;
  double height = 0;
  double time = 0;
  double gravity = -8;
  double velocity = 3.5;
  bool isStarted = false;
  double birdWidht = 0.08;
  double birdHeight = 0.08;
  int score=0;
  late int candy;

  void loadData() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      candy = data['candy'];
    });
  }

  final player = AudioPlayer();
  final player2 = AudioPlayer();
  final player3 = AudioPlayer();

  late final RewardedAd rewardedAd;
  final String rewardedAdUnitId = 'ca-app-pub-4225767728354504/1909713931';

  void _loadRewardedAd(){
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad){
          print('$ad loaded');
          rewardedAd = ad;
          _setFullScreenContentCallback();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load rewarded ad, Error: $error');
        },
      ),
    );
  }

  void _setFullScreenContentCallback(){
    if(rewardedAd==null) return;
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => print("$ad onShowedFullScreenContent"),
      onAdDismissedFullScreenContent: (RewardedAd ad){
        print("$ad onAdDismissedFullScreenContent");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
        print("$ad onAdFailedToShowFullScreenContent: $error");
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print("$ad Impression occured"),

    );
  }

  void _showRewardedAd(int sayi){
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        for(int i=0;i<sayi;i++){
          incrementsCandy();
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => changePage()),
              (route) => false,
        );
      },
    );
  }

  @override
  void initState() {
    _loadRewardedAd();
    player.play(AssetSource('sounds/birdwing.wav'), volume: 0.9);
    player.setReleaseMode(ReleaseMode.loop);
    loadData();
    // TODO: implement initState
    super.initState();
  }

  void incrementsCandy() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newCandy = candy + 1;
    if (newCandy >= 0) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'candy': newCandy});

      setState(() {
        candy = newCandy;
      });
    }
  }

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.25; // out of 2
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  int sayi = Random().nextInt(4);

  void startGame(){
    sayi = Random().nextInt(4);
    if(sayi == 0){
      barrierHeight[0][0] = 0.6;
      barrierHeight[0][1] = 0.8;
      barrierHeight[1][1] = 0.3;
      barrierHeight[1][0] = 1;
    }
    else if(sayi == 1){
      barrierHeight[0][0] = 0.5;
      barrierHeight[0][1] = 1;
      barrierHeight[1][1] = 0.8;
      barrierHeight[1][0] = 0.6;
    }
    else if(sayi == 2){
      barrierHeight[0][0] = 0.2;
      barrierHeight[0][1] = 1.1;
      barrierHeight[1][1] = 0.6;
      barrierHeight[1][0] = 0.8;
    }
    else if(sayi == 3){
      barrierHeight[0][0] = 0.6;
      barrierHeight[0][1] = 0.82;
      barrierHeight[1][0] = 0.8;
      barrierHeight[1][1] = 0.65;
    }
    isStarted = true;
    Timer.periodic(Duration(milliseconds: 15), (timer){
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = firstPosition - height;
      });

      if(isDead()){
        timer.cancel();
        isStarted = false;
        show();
      }

      moveMap();

      time += 0.01;
    });
  }

  void moveMap(){
    for(int i =0 ; i<barrierX.length; i++){
      setState(() {
        barrierX[i] -= 0.015;
      });

      if(barrierX[i]<-1.5){
        barrierX[i]+=3;
        setState(() {
          score++;
        });
      }
    }
  }

  void resetGame(){
    barrierX[0] += 2.1;
    barrierX[1] += 2.1;
    setState(() {
      birdY = 0;
      isStarted = false;
      time = 0;
      firstPosition = birdY;
    });
  }

  void show(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        player.stop();
        player3.play(AssetSource('sounds/gameover.mp3') ,volume: 0.3);
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Center(
            child: Column(
              children: [
                Text(
                  'gameover'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '${(score/10).toInt()} Candy',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                for(int i=0;i<(score/10).toInt();i++){
                  incrementsCandy();
                }
                setState(() {
                  barrierX[0] += 2.1;
                  barrierX[1] += 2.1;
                  birdY = 0;
                  isStarted = false;
                  time = 0;
                  firstPosition = birdY;
                });
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => changePage()),
                      (route) => false,
                );
              },
              child: Text("${(score/10).toInt()} Candy"),
            ),
            TextButton(
              onPressed: () {
                if((score/10).toInt()==0){
                  print('1');
                  setState(() {
                    barrierX[0] += 2.1;
                    barrierX[1] += 2.1;
                    birdY = 0;
                    isStarted = false;
                    time = 0;
                    firstPosition = birdY;
                  });
                  _showRewardedAd(1);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => changePage()),
                        (route) => false,
                  );
                }else{
                  print('cok');
                  int kazanc = ((score/10).toInt())*2;
                  setState(() {
                    barrierX[0] += 2.1;
                    barrierX[1] += 2.1;
                    birdY = 0;
                    isStarted = false;
                    time = 0;
                    firstPosition = birdY;
                  });
                  _showRewardedAd(kazanc);
                }
              },
              child: (score/10).toInt() == 0 ? Text("watch".tr) : Text("watch2x".tr),
            ),
          ],
        );
      },
    );
  }

  void jump(){
    setState(() {
      time = 0;
      firstPosition = birdY;
    });
  }

  bool isDead(){
    if(birdY<-1 || birdY>1){
      return true;
    }

    for(int i =0; i<barrierX.length;i++){
      if(barrierX[i]<=birdWidht &&
          barrierX[i] + barrierWidth >= -birdWidht &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])){
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        player2.play(AssetSource('sounds/boink.wav'));
        isStarted ? jump() : startGame();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/flappyBird/cloud3.png'),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      myBird(
                        birdHeight: birdHeight,
                        birdWidht: birdWidht,
                        birdY: birdY,
                      ),
                      Container(
                        alignment: Alignment(0,-0.25),
                        child: Text(
                          isStarted ? '' : 'TAP TO START',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[0][0],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[0][1],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: true,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierHeight: barrierHeight[1][0],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierHeight: barrierHeight[1][1],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/flappyBird/grass2.png'),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment(0,-0.40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('SCORE'),
                        Text(
                          isStarted ? '$score' : '$score',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
