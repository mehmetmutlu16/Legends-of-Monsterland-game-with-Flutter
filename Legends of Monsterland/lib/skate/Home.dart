import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../changePage.dart';
import 'barrier.dart';
import 'clickToStart.dart';
import 'dino.dart';
import 'gameHasOver.dart';
import 'score.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final player = AudioPlayer();
  final player2 = AudioPlayer();
  final player3 = AudioPlayer();

  bool hasStarted = false;
  int score = 0;
  int bestScore = 0;
  bool gameHasOver = false;
  bool centralJump = false;
  bool dinoHasPassed = false;

  double time2 = 0;
  double gravity = 9.8;
  double height = 0;
  double time = 0;
  double velocity = 4.2;

  double dinoX = -0.5;
  double dinoY = 1;
  double dinoWidth = 0.3;
  double dinoHeight = 0.4;

  double barrierX = 1;
  double barrierY = 1;
  double barrierWidth = 0.3;
  double barrierHeight = 0.4;

  late int candy;
  late int energy;

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
                _showRewardedAdEnergy();
                Navigator.pop(context);
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

  void _showRewardedAdEnergy(){
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        incrementsEnergy();
      },
    );
  }

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

  void incrementsEnergy() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newEnergy = energy + 5;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'energy': newEnergy});
    setState(() {
      energy = newEnergy;
    });
  }

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
    player.play(AssetSource('sounds/skateback.mp3'), volume: 0.3);
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

  void _showGameOverDialog(int score) {
    int winnings = (score/20).toInt();
    player.stop();
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text('gameover'.tr),
          content: Text('playagain'.tr),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if(energy<=0){
                    dontEnergy(context);
                    print('enerjiyok');
                  }else if(energy==1){
                    dontEnergy(context);
                  }else{
                    decreaseEnergy();
                    decreaseEnergy();
                    Navigator.pop(context);
                  }
                });
              },
              child: Text('repeat'.tr),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                for(int i=0;i<winnings;i++){
                  incrementsCandy();
                }
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => changePage()),
                      (route) => false,
                );
              },
              child: Text('$winnings Candy'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                if(winnings==0){
                  _showRewardedAd(1);
                }else{
                  _showRewardedAd(2*winnings);
                }
              },
              child: winnings == 0 ? Text("watch".tr) : Text("watch2x".tr),
            ),
          ],
        ),
      ),
    );
  }

  void startGame () {
    setState (() {
      hasStarted = true;
    });
    Timer.periodic ( Duration (milliseconds: 10), (timer)
    {
      if(detectForCollision())
      {
        bestScore = score;
        gameHasOver = true;
        player.pause();
        player3.play(AssetSource('sounds/skatecrash.wav'));
        timer.cancel();
        setState (() {
          if(score > bestScore)
          {
            bestScore= score;
          }
        });
        Future.delayed(Duration(milliseconds: 500), () {
          _showGameOverDialog(bestScore);
        });
      }

      loopForBarrier();

      updateForScore();

      setState (() {
        time2 -= 0.000001;
        barrierX = barrierX + time2;
        barrierX -= 0.015;
      });
    }); // Timer.periodic
  }

  void updateForScore() {
    if(barrierX < dinoX && dinoHasPassed == false)
    {
      setState (() {
        dinoHasPassed = true;
        score++;
      });
    }
  }

  void loopForBarrier () {
    setState (() {
      if (barrierX <= -1.2)
      {
        barrierX = 1.2;
        dinoHasPassed = false;
      }
    });
  }

  bool detectForCollision () {
    if(barrierX <= dinoX + dinoWidth -0.05 &&
        barrierX + barrierWidth -0.05 >= dinoX &&
        dinoY-0.05 >= barrierY - barrierHeight)
    {
      return true;
    }
    return false;
  }

  void jumpDino() {
    player2.play(AssetSource('sounds/skatejump.mp3'));
    centralJump = true;
    Timer.periodic(const Duration (milliseconds: 10), (timer)
    {
      height = -gravity / 2 * time * time + velocity * time;

      setState (() {
        if(1 - height > 1)
        {
          resetJumpDino();
          dinoY = 1;
          timer.cancel();
        }
        else
        {
          dinoY = 1 - height;
        }
      });

      if (gameHasOver)
      {
        timer.cancel();
      }

      time += 0.01;
    });

  }

  void resetJumpDino(){
    centralJump = false;
    time = 0;
  }

  void playAgain(){
    setState(() {
      gameHasOver = false;
      hasStarted = false;
      barrierX = 1.2;
      score = 0;
      dinoY = 1;
      centralJump = false;
      player.resume();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
        gameHasOver
            ? (playAgain)
            : (hasStarted ? (centralJump ? null : jumpDino) : startGame),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Center(
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/skate/wall.png',fit: BoxFit.cover,),

                      Score(
                        score: score,
                        bestScore: bestScore,
                      ),

                      dino(
                        dinoX: dinoX,
                        dinoY: dinoY - dinoHeight,
                        dinoWidth: dinoWidth,
                        dinoHeight: dinoHeight,
                      ),

                      barrier(
                        barrierX: barrierX,
                        barrierY: barrierY - barrierHeight,
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight,
                      ),

                      GameHasOver(
                        gamehasOver: gameHasOver,
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[900],
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.topLeft,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 10,
                        width: double.maxFinite,
                        color: Colors.grey[700],
                      ),
                    ),
                    clickToStart(
                      hasStarted: hasStarted,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
