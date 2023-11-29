import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/gameChoose.dart';
import '../changePage.dart';
import '../themeSettings.dart';
import 'grid.dart';

class board extends StatefulWidget {

  int imageChoose;

  board({required this.imageChoose});

  @override
  State<board> createState() => _boardState();
}

class _boardState extends State<board> {
  var numbers = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
  int move = 0;
  int secondsPassed = 0;
  bool isActive = false;
  late int candy;

  final player = AudioPlayer();
  final success = AudioPlayer();

  late Timer _timer;
  int _counter = 0;
  static const duration = Duration(seconds: 1);

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
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
    super.initState();
    numbers.shuffle();
    startTimer();
  }

  @override
  void dispose() {
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(_timer==null){
      _timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('4x4 MonsterPuzzle', style: baslikStili),
        backgroundColor: Colors.teal[400],
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              grid(numbers, size, clickGrid, widget.imageChoose),
              Expanded(child: buildImage()),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: reset,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                      ),
                      child: Text('Reset', style: icerikStili,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'move'.tr +': $move',
                        style: icerikStili
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        "time".tr + ": $_counter",
                        style: icerikStili
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(){
    if(widget.imageChoose==0) {
      return Image.asset('assets/puzzleGame/ant/reference.png');
    }
    else if(widget.imageChoose==1) {
      return Image.asset('assets/puzzleGame/mouse/reference.png');
    }
    return SizedBox(width: 0,height: 0,);
  }

  void clickGrid(index) {
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime(){
    if(isActive){
      setState(() {
        secondsPassed += 1;
      });
    }
  }

  void reset(){
    setState(() {
      numbers.shuffle();
      resetTimer();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            player.stop();
            success.play(AssetSource('sounds/success.mp3'), volume: 0.5);
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "youwon".tr,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 220.0,
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  incrementsCandy();
                                  incrementsCandy();
                                  incrementsCandy();
                                  incrementsCandy();
                                  incrementsCandy();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => changePage()),
                                        (route) => false,
                                  );
                                  },
                                child: Text(
                                  "5 Candy",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal[100],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _showRewardedAd(10);
                                },
                                child: Text(
                                  "watch2x".tr,
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal[100],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }
}

