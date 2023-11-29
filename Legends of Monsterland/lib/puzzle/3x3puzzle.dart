import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../changePage.dart';
import '../gameChoose.dart';
import '../themeSettings.dart';


class puzzle3x3 extends StatefulWidget {

  int imageChoose;

  puzzle3x3({required this.imageChoose});

  @override
  _puzzle3x3State createState() => _puzzle3x3State();
}

class _puzzle3x3State extends State<puzzle3x3> {
  List<int> numbers = List.generate(8, (index) => index + 1);
  int emptyIndex = 8;
  int move = 0;

  final player = AudioPlayer();
  final success = AudioPlayer();

  late Timer _timer;
  int _counter = 0;
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          _counter++;
        },
      ),
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  void resetTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _counter = 0;
    });
    startTimer();
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
    player.play(AssetSource('sounds/puzzleback.mp3'), volume: 0.5);
    player.setReleaseMode(ReleaseMode.loop);
    loadData();
    startTimer();
    numbers.shuffle();
    // TODO: implement initState
    super.initState();
    numbers.add(9);
  }

  @override
  void dispose() {
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  void _onTileClicked(int index) {
    move++;
    if (isAdjacent(index, emptyIndex)) {
      setState(() {
        swap(index, emptyIndex);
        emptyIndex = index;
      });
      checkIfSolved();
    }
  }

  bool isAdjacent(int index1, int index2) {
    int x1 = index1 % 3;
    int y1 = index1 ~/ 3;
    int x2 = index2 % 3;
    int y2 = index2 ~/ 3;

    return (x1 == x2 && (y1 - y2).abs() == 1) || (y1 == y2 && (x1 - x2).abs() == 1);
  }

  void swap(int index1, int index2) {
    int temp = numbers[index1];
    numbers[index1] = numbers[index2];
    numbers[index2] = temp;
  }

  void reset(){
    setState(() {
      numbers.shuffle();
      resetTimer();
      move = 0;
    });
  }

  void checkIfSolved() {
    bool solved = true;
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i] != i + 1) {
        solved = false;
        break;
      }
    }

    if (solved) {
      player.stop();
      success.play(AssetSource('sounds/success.mp3'), volume: 0.5);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          stopTimer();
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.teal[100],
              title: Text('congratulations'.tr),
              content: Text('solved'.tr),
              actions: <Widget>[
                TextButton(
                  child: Text('3 Candy'),
                  onPressed: () {
                    incrementsCandy();
                    incrementsCandy();
                    incrementsCandy();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => changePage()),
                          (route) => false,
                    );
                    },
                ),
                TextButton(
                  onPressed: () {
                    _showRewardedAd(6);
                  },
                  child: Text("watch2x".tr),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget buildImage(){
    if(widget.imageChoose==0) {
      return Image.asset('assets/puzzleGame/3x3/ghost/reference.png');
    }
    else if(widget.imageChoose==1) {
      return Image.asset('assets/puzzleGame/3x3/bird/reference.png');
    }
    else if(widget.imageChoose==2) {
      return Image.asset('assets/puzzleGame/3x3/fish/reference.png');
    }
    return SizedBox(width: 0,height: 0,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3x3 MonsterPuzzle', style: baslikStili,),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                if (index == emptyIndex) {
                  return Container();
                } else {
                  return GestureDetector(
                    onTap: () => _onTileClicked(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Center(
                        child: choosenPhoto(index),
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: buildImage(),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                          'move'.tr + ': $move',
                          style: icerikStili
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                          'time'.tr + ': $_counter',
                          style: icerikStili
                      ),
                    ),
                    ElevatedButton(
                      onPressed: reset,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                      ),
                      child: Text('Reset', style: icerikStili,),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Image choosenPhoto(int index) {
    if (widget.imageChoose == 0) {
      return Image.asset(
          'assets/puzzleGame/3x3/ghost/image_part_00${numbers[index]}.png');
    }
    if (widget.imageChoose == 1) {
      return Image.asset(
          'assets/puzzleGame/3x3/bird/image_part_00${numbers[index]}.png');
    }
    if (widget.imageChoose == 2) {
      return Image.asset(
          'assets/puzzleGame/3x3/fish/image_part_00${numbers[index]}.png');
    }
    return Image.asset(
        'assets/puzzleGame/3x3/bird/image_part_00${numbers[index]}.png');
  }
}
