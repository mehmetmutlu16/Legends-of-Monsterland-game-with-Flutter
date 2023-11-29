import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/changePage.dart';
import 'package:pokedex/pokePages/pokemons.dart';
import 'package:pokedex/themeSettings.dart';

class warPage extends StatefulWidget {

  String name;
  String image;
  String type;
  warPage(this.image, this.type, this.name);

  @override
  State<warPage> createState() => _warPageState();
}

class _warPageState extends State<warPage> {

  String typePlayer = pokemons.getpokeType1(1);

  bool _isFirstImage = true;
  double _enemyHealth = 25.0;
  double _playerHealth = 25.0;
  String buttonText = '';
  Random random = Random();
  Random random2 = Random();
  int counter = 0;

  final player = AudioPlayer();
  final player2 = AudioPlayer();
  final player3 = AudioPlayer();
  final gameover = AudioPlayer();
  final success = AudioPlayer();

  bool isBlue = false;

  List<Map<String, dynamic>> enemyFighter = [
    {'name': 'Florass', 'image': 'assets/warCards/001-min.png', 'type': 'grass'},
    {'name': 'Sparkie', 'image': 'assets/warCards/002-min.png', 'type': 'fire'},
    {'name': 'Sparken', 'image': 'assets/warCards/003-min.png', 'type': 'fire'},
    {'name': 'Aquadra', 'image': 'assets/warCards/004-min.png', 'type': 'water'},
    {'name': 'Shockwing', 'image': 'assets/warCards/005-min.png', 'type': 'flying'},
    {'name': 'Zapwing', 'image': 'assets/warCards/006-min.png', 'type': 'flying'},
    {'name': 'Joltur', 'image': 'assets/warCards/007-min.png', 'type': 'electric'},
    {'name': 'Joltrik', 'image': 'assets/warCards/008-min.png', 'type': 'electric'},
    {'name': 'Mysticon', 'image': 'assets/warCards/009-min.png', 'type': 'psychic'},
    {'name': 'Psypup', 'image': 'assets/warCards/010-min.png', 'type': 'grass'},
    {'name': 'Psydog', 'image': 'assets/warCards/011-min.png', 'type': 'grass'},
    {'name': 'Dolphineon', 'image': 'assets/warCards/012-min.png', 'type': 'water'},
    {'name': 'Rockslide', 'image': 'assets/warCards/013-min.png', 'type': 'rock'},
    {'name': 'Rockfist', 'image': 'assets/warCards/014-min.png', 'type': 'rock'},
    {'name': 'Silentpaw', 'image': 'assets/warCards/015-min.png', 'type': 'fight'},
    {'name': 'Shadowclaw', 'image': 'assets/warCards/016-min.png', 'type': 'fight'},
    {'name': 'Electromon', 'image': 'assets/warCards/017-min.png', 'type': 'electric'},
    {'name': 'Eaglestorm', 'image': 'assets/warCards/018-min.png', 'type': 'flying'},
    {'name': 'Skywing', 'image': 'assets/warCards/019-min.png', 'type': 'flying'},
    {'name': 'Woolie', 'image': 'assets/warCards/020-min.png', 'type': 'electric'},
    {'name': 'Wooliec', 'image': 'assets/warCards/021-min.png', 'type': 'electric'},
    {'name': 'Wooliectra', 'image': 'assets/warCards/022-min.png', 'type': 'electric'},
    {'name': 'Spookums', 'image': 'assets/warCards/023-min.png', 'type': 'ghost'},
    {'name': 'Spookram', 'image': 'assets/warCards/024-min.png', 'type': 'ghost'},
    {'name': 'Nimowl', 'image': 'assets/warCards/025-min.png', 'type': 'psychic'},
    {'name': 'Wisowl', 'image': 'assets/warCards/026-min.png', 'type': 'psychic'},
    {'name': 'Fliefox', 'image': 'assets/warCards/027-min.png', 'type': 'normal'},
    {'name': 'Fluffox', 'image': 'assets/warCards/028-min.png', 'type': 'normal'},
    {'name': 'Drogie', 'image': 'assets/warCards/029-min.png', 'type': 'ice'},
    {'name': 'Drogice', 'image': 'assets/warCards/030-min.png', 'type': 'ice'},
    {'name': 'Drogrost', 'image': 'assets/warCards/031-min.png', 'type': 'ice'},
    {'name': 'Monrass', 'image': 'assets/warCards/032-min.png', 'type': 'grass'},
    {'name': 'Gorrass', 'image': 'assets/warCards/033-min.png', 'type': 'grass'},
    {'name': 'Flamerock', 'image': 'assets/warCards/034-min.png', 'type': 'fire'},
    {'name': 'Flameburst', 'image': 'assets/warCards/035-min.png', 'type': 'fire'},
    {'name': 'Vaseblade', 'image': 'assets/warCards/036-min.png', 'type': 'grass'},
    {'name': 'Leafblade', 'image': 'assets/warCards/037-min.png', 'type': 'grass'},
    {'name': 'Forestblade', 'image': 'assets/warCards/038-min.png', 'type': 'grass'},
    {'name': 'Glimmer', 'image': 'assets/warCards/039-min.png', 'type': 'ice'},
    {'name': 'Schimmer', 'image': 'assets/warCards/040-min.png', 'type': 'ice'},
    {'name': 'Dunebelle', 'image': 'assets/warCards/041-min.png', 'type': 'rock'},
    {'name': 'Infernus', 'image': 'assets/warCards/042-min.png', 'type': 'fire'},
    {'name': 'Blazenus', 'image': 'assets/warCards/043-min.png', 'type': 'fire'},
    {'name': 'Whispurr', 'image': 'assets/warCards/044-min.png', 'type': 'ghost'},
    {'name': 'Ghosteroid', 'image': 'assets/warCards/045-min.png', 'type': 'ghost'},
    {'name': 'Toxibug', 'image': 'assets/warCards/046-min.png', 'type': 'bug'},
    {'name': 'Toxiban', 'image': 'assets/warCards/047-min.png', 'type': 'bug'},
    {'name': 'Citrusclaw', 'image': 'assets/warCards/048-min.png', 'type': 'normal'},
    {'name': 'Gingerpaw', 'image': 'assets/warCards/049-min.png', 'type': 'normal'},
    {'name': 'Poliba', 'image': 'assets/warCards/050-min.png', 'type': 'poison'},
    {'name': 'Skov', 'image': 'assets/warCards/051-min.png', 'type': 'grass'},
    {'name': 'Skovie', 'image': 'assets/warCards/052-min.png', 'type': 'grass'},
    {'name': 'Rhinohorn', 'image': 'assets/warCards/053-min.png', 'type': 'rock'},
    {'name': 'Rhinorock', 'image': 'assets/warCards/054-min.png', 'type': 'rock'},
    {'name': 'Seebreeze', 'image': 'assets/warCards/055-min.png', 'type': 'water'},
    {'name': 'Seastorm', 'image': 'assets/warCards/056-min.png', 'type': 'water'},
    {'name': 'Flamie', 'image': 'assets/warCards/057-min.png', 'type': 'fire'},
    {'name': 'Flabie', 'image': 'assets/warCards/058-min.png', 'type': 'fire'},
    {'name': 'Feliphys', 'image': 'assets/warCards/059-min.png', 'type': 'psychic'},
    {'name': 'Mindlion', 'image': 'assets/warCards/060-min.png', 'type': 'psychic'},
    {'name': 'Dracotide', 'image': 'assets/warCards/061-min.png', 'type': 'dragon'},
    {'name': 'Dracoflow', 'image': 'assets/warCards/062-min.png', 'type': 'dragon'},
    {'name': 'Frostbite', 'image': 'assets/warCards/063-min.png', 'type': 'ice'},
    {'name': 'Frostitoes', 'image': 'assets/warCards/064-min.png', 'type': 'ice'},
    {'name': 'Minei', 'image': 'assets/warCards/065-min.png', 'type': 'rock'},
    {'name': 'Minerax', 'image': 'assets/warCards/066-min.png', 'type': 'rock'},
    {'name': 'Fluffernut', 'image': 'assets/warCards/067-min.png', 'type': 'grass'},
    {'name': 'Razorleaf', 'image': 'assets/warCards/068-min.png', 'type': 'grass'},
    {'name': 'Spork', 'image': 'assets/warCards/069-min.png', 'type': 'electric'},
    {'name': 'Sporkle', 'image': 'assets/warCards/070-min.png', 'type': 'electric'},
    {'name': 'Zazzle', 'image': 'assets/warCards/071-min.png', 'type': 'electric'},
    {'name': 'Chiliwrath', 'image': 'assets/warCards/072-min.png', 'type': 'fire'},
    {'name': 'Chiliclaw', 'image': 'assets/warCards/073-min.png', 'type': 'fire'},
    {'name': 'Doldog', 'image': 'assets/warCards/074-min.png', 'type': 'ice'},
    {'name': 'Roseburst', 'image': 'assets/warCards/075-min.png', 'type': 'grass'},
    {'name': 'Flowerburst', 'image': 'assets/warCards/076-min.png', 'type': 'grass'},
    {'name': 'Frostie', 'image': 'assets/warCards/077-min.png', 'type': 'ice'},
    {'name': 'Froster', 'image': 'assets/warCards/078-min.png', 'type': 'ice'},
    {'name': 'Dolie', 'image': 'assets/warCards/079-min.png', 'type': 'water'},
    {'name': 'Dolphie', 'image': 'assets/warCards/080-min.png', 'type': 'water'},
    {'name': 'Fenr', 'image': 'assets/warCards/081-min.png', 'type': 'dragon'},
    {'name': 'Fenrago', 'image': 'assets/warCards/082-min.png', 'type': 'dragon'},
    {'name': 'Mindwave', 'image': 'assets/warCards/083-min.png', 'type': 'psychic'},
    {'name': 'Psywave', 'image': 'assets/warCards/084-min.png', 'type': 'psychic'},
    {'name': 'Boolder', 'image': 'assets/warCards/085-min.png', 'type': 'rock'},
    {'name': 'Boolderback', 'image': 'assets/warCards/086-min.png', 'type': 'rock'},
    {'name': 'Aquazoid', 'image': 'assets/warCards/087-min.png', 'type': 'water'},
    {'name': 'Thunderstrike', 'image': 'assets/warCards/088-min.png', 'type': 'electric'},
    {'name': 'Bippitibop', 'image': 'assets/warCards/089-min.png', 'type': 'ghost'},
    {'name': 'Venomous', 'image': 'assets/warCards/090-min.png', 'type': 'poison'},
    {'name': 'Psycodactyl', 'image': 'assets/warCards/091-min.png', 'type': 'psychic'},
  ];

  late String enemyName;
  late String enemyImage;
  late String enemyImage2;
  late String enemyType;
  late String playerImage2;



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
  void initState(){
    _loadRewardedAd();

    player.play(AssetSource('sounds/warback.mp3'), volume: 0.3);
    player.setReleaseMode(ReleaseMode.loop);

    int enemy = random2.nextInt(90);
    enemyName = enemyFighter[enemy]['name'];
    enemyImage = enemyFighter[enemy]['image'];
    enemyType = enemyFighter[enemy]['type'];
    enemyImage2 = enemyFighter[enemy]['image'];
    playerImage2 = widget.image;

    loadData();

    super.initState();
  }

  void endGame() {
    if (_enemyHealth <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          success.play(AssetSource('sounds/success.mp3'));
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.teal[100],
              title: Text('congratulations'.tr),
              content: Text('youwon'.tr),
              actions: [
                TextButton(
                  child: Text('okay'.tr),
                  onPressed: () {
                    player.stop();
                    incrementsCandy();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => changePage()),
                          (route) => false,
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    player.stop();
                    _showRewardedAd(2);
                  },
                  child: Text("watch2x".tr),
                ),
              ],
            ),
          );
        },
      );
    } else if (_playerHealth <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          gameover.play(AssetSource('sounds/gameover.mp3'));
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.teal[100],
              title: Text('gameover'.tr),
              content: Text('youlost'.tr),
              actions: [
                TextButton(
                  child: Text('okay'.tr),
                  onPressed: () {
                    player.stop();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => changePage()),
                          (route) => false,
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    player.stop();
                    _showRewardedAd(1);
                  },
                  child: Text("watch".tr),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void skill(){
    List<String> atcList = playerImage2.split('');
    atcList[7] = "a";
    atcList[8] = "t";
    atcList[9] = "c";
    playerImage2 = atcList.join();

    List<String> dmgList = enemyImage2.split('');
    dmgList[7] = "d";
    dmgList[8] = "m";
    dmgList[9] = "g";
    enemyImage2 = dmgList.join();
    if(counter>=3){
      if (!_isButtonDisabled) {
        _disableButton();
        int attackValue = random.nextInt(6)+4;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 2), () {
          skillEnemy();
        });
        setState(() {
          changeText();
        });
        endGame();
        counter=0;
      }
    }
    else{
      setState(() {
        changeText5(widget.name);
      });
    }
  }

  void skillEnemy(){
    int attackValue = random.nextInt(6)+4;
    List<String> atcList = enemyImage2.split('');
    atcList[7] = "a";
    atcList[8] = "t";
    atcList[9] = "c";
    enemyImage2 = atcList.join();

    List<String> dmgList = playerImage2.split('');
    dmgList[7] = "d";
    dmgList[8] = "m";
    dmgList[9] = "g";
    playerImage2 = dmgList.join();
    setState(() {
      _playerHealth-=attackValue;
      if(_playerHealth<0){
        _playerHealth=0;
      }
    });
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        player3.play(AssetSource('sounds/punch2.wav'));
        if(attackValue>=7){
          changeText2(enemyName);
        }else if(5<=attackValue && attackValue<7){
          changeText3(enemyName);
        }else if(attackValue<5){
          changeText4(enemyName);
        }
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
    });
    endGame();
  }

  void attack1() {
    if (!_isButtonDisabled) {
      _disableButton();
      int attackValue = random.nextInt(6)+1;
      List<String> atcList = playerImage2.split('');
      atcList[7] = "a";
      atcList[8] = "t";
      atcList[9] = "c";
      playerImage2 = atcList.join();

      List<String> dmgList = enemyImage2.split('');
      dmgList[7] = "d";
      dmgList[8] = "m";
      dmgList[9] = "g";
      enemyImage2 = dmgList.join();

      if(widget.type == 'grass' && enemyType == 'water'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;
      }
      else if(widget.type == 'water' && enemyType == 'fire'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'water' && enemyType == 'rock'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'fire' && enemyType == 'grass'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'fire' && enemyType == 'ice'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'fire' && enemyType == 'bug'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'electric' && enemyType == 'flying'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'electric' && enemyType == 'water'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'rock' && enemyType == 'ice'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'rock' && enemyType == 'fire'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'rock' && enemyType == 'electric'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'ice' && enemyType == 'dragon'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'ice' && enemyType == 'grass'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'ice' && enemyType == 'flying'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'fight' && enemyType == 'normal'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'fight' && enemyType == 'ice'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'fight' && enemyType == 'rock'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'poison' && enemyType == 'grass'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'poison' && enemyType == 'bug'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'flying' && enemyType == 'poison'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'flying' && enemyType == 'bug'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'flying' && enemyType == 'grass'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'psychic' && enemyType == 'normal'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'psychic' && enemyType == 'fight'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'bug' && enemyType == 'poison'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'bug' && enemyType == 'psychic'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'ghost' && enemyType == 'normal'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'dragon' && enemyType == 'grass'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else if(widget.type == 'dragon' && enemyType == 'dragon'){
        isBlue = true;
        attackValue+=2;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      else{
        isBlue = true;
        setState(() {
          _enemyHealth-=attackValue;
          if(_enemyHealth<0){
            _enemyHealth=0;
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            player2.play(AssetSource('sounds/punch.wav'));
            if(attackValue>=7){
              changeText2(widget.name);
            }else if(5<=attackValue && attackValue<7){
              changeText3(widget.name);
            }else if(attackValue<5){
              changeText4(widget.name);
            }
          });
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isFirstImage = !_isFirstImage;
          });
        });
        endGame();
        counter++;

      }
      Future.delayed(Duration(seconds: 2), () {
        enemyAttack();
      });
      setState(() {
        changeText();
      });
    }
  }

  void enemyAttack() {
    int attackValue = random.nextInt(6) + 1;

    List<String> atcList = enemyImage2.split('');
    atcList[7] = "a";
    atcList[8] = "t";
    atcList[9] = "c";
    enemyImage2 = atcList.join();

    List<String> dmgList = playerImage2.split('');
    dmgList[7] = "d";
    dmgList[8] = "m";
    dmgList[9] = "g";
    playerImage2 = dmgList.join();

    if(widget.type == 'grass' && enemyType == 'water'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });
        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'water' && enemyType == 'fire'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'water' && enemyType == 'rock'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'fire' && enemyType == 'grass'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'fire' && enemyType == 'ice'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'fire' && enemyType == 'bug'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'electric' && enemyType == 'flying'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'electric' && enemyType == 'water'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'rock' && enemyType == 'ice'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'rock' && enemyType == 'fire'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'rock' && enemyType == 'electric'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'ice' && enemyType == 'dragon'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'ice' && enemyType == 'grass'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'ice' && enemyType == 'flying'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'fight' && enemyType == 'normal'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'fight' && enemyType == 'ice'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'fight' && enemyType == 'rock'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'poison' && enemyType == 'grass'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'poison' && enemyType == 'bug'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'flying' && enemyType == 'poison'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'flying' && enemyType == 'bug'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'flying' && enemyType == 'grass'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'psychic' && enemyType == 'normal'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'psychic' && enemyType == 'ground'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'psychic' && enemyType == 'fight'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'bug' && enemyType == 'poison'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'bug' && enemyType == 'psychic'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'ghost' && enemyType == 'normal'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'dragon' && enemyType == 'grass'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else if(widget.type == 'dragon' && enemyType == 'dragon'){
      isBlue = false;
      attackValue+=2;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }
    else{
      isBlue = false;
      setState(() {
        _playerHealth -= attackValue;
        if (_playerHealth < 0) {
          setState(() {
            _playerHealth = 0;
          });
        }
      });
      changeText();
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          player3.play(AssetSource('sounds/punch2.wav'));
          if(attackValue>=7){
            changeText2(enemyName);
          }else if(5<=attackValue && attackValue<7){
            changeText3(enemyName);
          }else if(attackValue<5){
            changeText4(enemyName);
          }
        });        setState(() {
          _isFirstImage = !_isFirstImage;
        });
      });
      endGame();
    }

  }

  void changeText5(String pokeName) {
    setState(() {
      buttonText = '$pokeName ' + 'isnotready'.tr;
    });
  }

  void changeText() {
    setState(() {
      buttonText = '';
    });
  }

  void changeText2(String pokeName) {
    setState(() {
      buttonText = 'verypowerful'.tr +' $pokeName';
    });
  }

  void changeText3(String pokeName) {
    setState(() {
      buttonText = 'powerful'.tr + ' $pokeName';
    });
  }

  void changeText4(String pokeName) {
    setState(() {
      buttonText = 'weak'.tr + ' $pokeName';
    });
  }

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

  bool _isButtonDisabled = false;

  void _disableButton() {
    setState(() {
      _isButtonDisabled = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment(-1.2,0.7),
              child: Container(
                width: 300,
                height: 300,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 10),
                  child: _isFirstImage
                      ? Image.asset(widget.image, key: ValueKey(1))
                      : Image.asset(playerImage2, key: ValueKey(2)),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment(1.2, -0.8),
              child: Container(
                width: 300,
                height: 300,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 10),
                  child: _isFirstImage
                      ? Image.asset(enemyImage, key: ValueKey(1))
                      : Image.asset(enemyImage2, key: ValueKey(2)),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: attack1,
                    child: Text('Attack'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonDisabled ? Colors.grey : Colors.blue,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Container(height: 45, color: counter >= 1 ? Colors.lightGreen : Colors.transparent,)),
                            Container(width: 10, color: Colors.grey[850],),
                            Expanded(child: Container(height: 45, color: counter >= 2 ? Colors.lightGreen : Colors.transparent,)),
                            Container(width: 10, color: Colors.grey[850],),
                            Expanded(child: Container(height: 45, color: counter >= 3 ? Colors.lightGreen : Colors.transparent,)),
                          ],
                        ),
                        Center(child: Text('SKILL BAR', style: baslikStili,),),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: skill,
                    child: Text('Skill'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonDisabled ? Colors.grey : Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: isBlue ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: isBlue ? Colors.blue : Colors.red,width:8, ),
                ),
                child: Text(buttonText, style: TextStyle(fontSize: 20,),),
              ),
            ),
            Align(
              alignment: Alignment(-0.9, -0.9),
              child: Container(
                width: double.maxFinite,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "health".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Text(
                          "${(_enemyHealth).toInt()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(_enemyHealth > 0.2 ? Colors.red : Colors.white),
                      value: _enemyHealth,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.9, 0.85),
              child: Container(
                width: double.maxFinite,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "health".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Text(
                          "${(_playerHealth).toInt()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(_playerHealth > 0.2 ? Colors.red : Colors.white),
                      value: _playerHealth,
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

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }
}
