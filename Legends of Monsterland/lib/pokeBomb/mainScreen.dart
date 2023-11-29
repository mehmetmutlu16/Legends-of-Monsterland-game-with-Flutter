import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../changePage.dart';
import 'game.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  pokeBomb game = pokeBomb();

  late Timer _timer;
  int _counter = 0;

  final player = AudioPlayer();

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

  late int candy;
  late int energy;

  void loadData() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      energy = data['energy'];
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
        num amount = rewardItem.amount;
        print('you earned: $amount');
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
    game.resetGame();
    game.gameOver = false;
    player.play(AssetSource('sounds/mineback.mp3'), volume: 0.1);
    player.setReleaseMode(ReleaseMode.loop);
    startTimer();
    loadData();
    // TODO: implement initState
    super.initState();
    game.generateMap();
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

  void _showSuccessDialog() {
    player.stop();
    stopTimer();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal[100],
        title: Text('congratulations'.tr),
        actions: [
          TextButton(
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
            child: Text('5 Candy'),
          ),
          TextButton(
            onPressed: () {
              _showRewardedAd(10);
            },
            child: Text('watch2x'.tr),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    player.stop();
    stopTimer();
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
                  resetTimer();
                  game.resetGame();
                  game.gameOver = false;
                  decreaseEnergy();
                  Navigator.pop(context);
                });
              },
              child: Text('repeat'.tr),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('lookmines'.tr),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _showRewardedAd(1);
              },
              child: Text('watch'.tr),
            ),
          ],
        ),
      ),
    );
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
    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 0.0,
        centerTitle: true,
        title: const Text('MonsterBomb'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.flag,
                          color: Colors.green,
                          size: 34,
                        ),
                      ),
                      Expanded(
                        child: Text('hold'.tr, style: TextStyle(color: Colors.white, fontSize: 16),),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.timer,
                          color: Colors.green,
                          size: 34,
                        ),
                      ),
                      Expanded(child: Text('${_counter} ' + 'second'.tr, style: TextStyle(color: Colors.white, fontSize: 16),)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 450,
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: pokeBomb.cells,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: pokeBomb.row,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext ctx, index){
                return GestureDetector(
                  onTap: game.gameOver ? null : (){
                    setState(() {
                      game.getClickedCell(game.gameMap[index]);
                      if (game.gameOver) {
                        _showGameOverDialog();
                        stopTimer();
                      }
                      if(game.isGameFinished()){
                        _showSuccessDialog();
                      }
                    });
                  },
                  onLongPress: game.gameOver ? null : () {
                    setState(() {
                      game.toggleFlaggedCell(game.gameMap[index]);
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                    ),
                    child: Center(
                      child: Text(
                        game.gameMap[index].reveal
                            ? "${game.gameMap[index].content}"
                            : game.gameMap[index].flagged
                            ? "🚩" // bayrak ikonu
                            : "",
                        style: TextStyle(
                          color: game.gameMap[index].reveal
                              ? game.gameMap[index].content == "X"
                              ? Colors.pink
                              : Colors.white
                              : game.gameMap[index].flagged
                              ? Colors.green // bayrak rengi
                              : Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            game.gameOver
                ? "youlost".tr
                : game.isGameFinished()
                ? "youwon".tr
                : "",
            style: const TextStyle(color: Colors.black),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.teal[100],
                      ),
                      onPressed: (){
                        setState(() {
                          if(energy<=0){
                            dontEnergy(context);
                            print('enerjiyok');
                          }else{
                            resetTimer();
                            game.resetGame();
                            game.gameOver = false;
                            decreaseEnergy();
                          }
                        });
                      },
                      child: Text('repeat'.tr, style: TextStyle(color: Colors.black, fontSize: 15),),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.teal[100],
                      ),
                      onPressed: (){
                        player.stop();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Text('backtomainmenu'.tr, style: TextStyle(color: Colors.black, fontSize: 15),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
