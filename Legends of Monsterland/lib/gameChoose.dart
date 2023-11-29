import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/cardGame/cardGame2.dart';
import 'package:pokedex/flappyBird/birdGame.dart';
import 'package:pokedex/pokeBomb/mainScreen.dart';
import 'package:pokedex/puzzle/imageChoose.dart';
import 'package:pokedex/puzzle/imageChoose3x3.dart';
import 'package:pokedex/skate/Home.dart';
import 'package:pokedex/tetris/tetris.dart';
import 'package:pokedex/themeSettings.dart';

import 'changePage.dart';

class gameChoose extends StatefulWidget {
  const gameChoose({Key? key}) : super(key: key);

  @override
  State<gameChoose> createState() => _gameChooseState();
}

class _gameChooseState extends State<gameChoose> with WidgetsBindingObserver{
  int candy = 0;
  int energy = 0;

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

  void decreaseCandy() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newCandy = candy - 1;
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
  final player = AudioPlayer();

  bool isPlaying = false;

  @override
  void initState() {
    loadData();
    _loadRewardedAd();
    WidgetsBinding.instance.addObserver(this);
    player.play(AssetSource('sounds/background2.mp3'));
    player.setReleaseMode(ReleaseMode.loop);
    isPlaying = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
      isPlaying = false;
    } else if (state == AppLifecycleState.resumed) {
      if (!isPlaying) {
        player.resume();
        isPlaying = true;
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.stop();
    // TODO: implement dispose
    super.dispose();
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

  void _showRewardedAdEnergy(){
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        incrementsEnergy();
        Navigator.push(context, MaterialPageRoute(builder: (context) => changePage()));
      },
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
              onPressed: (){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.all(12),
              child: GestureDetector(
                onTap: (){
                  switch(index){
                    case 0: confirmCard();
                      break;
                    case 1: confirmFlappy();
                      break;
                    case 2: confirmTetris();
                      break;
                    case 3: dimensionChoose(context);
                      break;
                    case 4: confirmSkate();
                      break;
                    case 5: confirmPokeBomb();
                      break;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.teal[400],
                  ),
                  child: Image.asset('assets/gameLogos/00${index+1}.png'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  confirmCard(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text("cardgame".tr),
          content: Text("confirmcard".tr),
          actions: <Widget>[
            TextButton(
              child: Text("back".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("letsgo".tr),
              onPressed: () {
                player.stop();
                if(energy<=0){
                  dontEnergy(context);
                  print('enerjiyok');
                }else{
                  decreaseEnergy();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OyunSayfasi()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  confirmFlappy(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text("MonsterFly"),
          content: Text("monsterfly".tr),
          actions: <Widget>[
            TextButton(
              child: Text("back".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("letsgo".tr),
              onPressed: () {
                player.stop();
                if(energy<=0){
                  dontEnergy(context);
                }else if(energy==1){
                  dontEnergy(context);
                }else{
                  decreaseEnergy();
                  decreaseEnergy();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => birdGame()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  confirmTetris(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text("MonsterTetris"),
          content: Text("monstertetris".tr),
          actions: <Widget>[
            TextButton(
              child: Text("back".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("letsgo".tr),
              onPressed: () {
                player.stop();
                if(energy<=0){
                  dontEnergy(context);
                }else if(energy==1){
                  dontEnergy(context);
                }else{
                  decreaseEnergy();
                  decreaseEnergy();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => tetris()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  confirmPuzzle(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: const Text("MonsterPuzzle"),
          content: Text("confirmcard".tr),
          actions: <Widget>[
            TextButton(
              child: Text("back".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("letsgo".tr),
              onPressed: () {
                player.stop();
                decreaseEnergy();
                Navigator.push(context, MaterialPageRoute(builder: (context) => imageChoose()));
                },
            ),
          ],
        );
      },
    );
  }

  confirmSkate(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: const Text("MonsterSkate"),
          content: Text("skate".tr),
          actions: <Widget>[
            TextButton(
              child: Text("back".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("letsgo".tr),
              onPressed: () {
                player.stop();
                if(energy<=0){
                  dontEnergy(context);
                }else if(energy==1){
                  dontEnergy(context);
                }else{
                  decreaseEnergy();
                  decreaseEnergy();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  confirmPokeBomb(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: const Text("MonsterBomb"),
          content: Text("confirmmine".tr),
          actions: <Widget>[
            TextButton(
              child: Text("back".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("letsgo".tr),
              onPressed: () {
                player.stop();
                if(energy<=0){
                  dontEnergy(context);
                  print('enerjiyok');
                }else{
                  decreaseEnergy();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => mainScreen()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void dimensionChoose(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text('puzzlesize'.tr),
          content: Text('choosepuzzlesize'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('3X3'),
              onPressed: () {
                player.stop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => imageChoose3x3()));
              },
            ),
            TextButton(
              child: Text('4X4'),
              onPressed: () {
                player.stop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => imageChoose()));
              },
            ),
          ],
        );
      },
    );
  }

  PreferredSize _appBar(){
    return PreferredSize(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.teal[400],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8,right: 30, left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$energy/20', style: metinStili,),
                      Icon(Icons.electric_bolt, size: 17,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('games'.tr, style: baslikStili),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$candy', style: metinStili,),
                      Image.asset('assets/shopPage/starIcon.png', width: 20, height: 20,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size.fromHeight(50),
    );
  }
}
