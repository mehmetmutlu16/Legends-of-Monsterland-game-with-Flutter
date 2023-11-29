import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/themeSettings.dart';

import '../changePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kart Eşleştirme Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OyunSayfasi(),
    );
  }
}

class OyunSayfasi extends StatefulWidget {
  @override
  _OyunSayfasiState createState() => _OyunSayfasiState();
}

class _OyunSayfasiState extends State<OyunSayfasi> {
  List<String> _kartlar = [];
  List<int> _acikKartlar = [];
  int? _oncekiSecim;
  int _dogruTahminSayisi = 0;
  bool _tumKartlarAcildi = false;
  int sayi = 0;
  late int candy;
  late Timer _timer;
  int _counter = 0;

  late final RewardedAd rewardedAd;
  final String rewardedAdUnitId = 'ca-app-pub-4225767728354504/1909713931';


  RewardedAd? _rewardedAd;
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

  final player = AudioPlayer();
  final success = AudioPlayer();

  @override
  void initState() {
    _loadRewardedAd();
    player.play(AssetSource('sounds/cardgame.wav'), volume: 0.3);
    player.setReleaseMode(ReleaseMode.loop);
    loadData();
    super.initState();
    _kartlariOlustur();
    startTimer();
  }

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

  void _showRewardedAd(){
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        incrementsCandy();
        incrementsCandy();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => changePage()),
              (route) => false,
        );
      },
    );
  }

  @override
  void dispose() {
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  List<String> _resimler = [
    'assets/pokemons/001.png',
    'assets/pokemons/002.png',
    'assets/pokemons/003.png',
    'assets/pokemons/004.png',
    'assets/pokemons/005.png',
    'assets/pokemons/006.png',
    'assets/pokemons/007.png',
    'assets/pokemons/008.png',
  ];


  void _kartlariOlustur() {
    _kartlar.clear();
    _kartlar.add('assets/card/001.png');
    _kartlar.add('assets/card/001.png');
    _kartlar.add('assets/card/002.png');
    _kartlar.add('assets/card/002.png');
    _kartlar.add('assets/card/003.png');
    _kartlar.add('assets/card/003.png');
    _kartlar.add('assets/card/004.png');
    _kartlar.add('assets/card/004.png');
    _kartlar.add('assets/card/005.png');
    _kartlar.add('assets/card/005.png');
    _kartlar.add('assets/card/006.png');
    _kartlar.add('assets/card/006.png');
    _kartlar.add('assets/card/007.png');
    _kartlar.add('assets/card/007.png');
    _kartlar.add('assets/card/008.png');
    _kartlar.add('assets/card/008.png');
    _kartlar.shuffle();
  }


  void _kartAc(int index) {
    if (sayi >= 2 || _acikKartlar.contains(index)) return;

    if (_oncekiSecim == null) {
      setState(() {
        _acikKartlar.add(index);
        sayi++;
      });
      _oncekiSecim = index;
    } else {
      int oncekiKart = _oncekiSecim!;
      if (_kartlar[oncekiKart] == _kartlar[index]) {
        setState(() {
          _acikKartlar.add(index);
          _dogruTahminSayisi++;
          sayi=0;
        });
        if (_dogruTahminSayisi == 8) {
          _oyunuBitir();
        }
      } else {
        setState(() {
          _acikKartlar.add(index);
          sayi++;
        });
        Timer(Duration(seconds: 1), () {
          setState(() {
            _acikKartlar.remove(oncekiKart);
            sayi--;
            _acikKartlar.remove(index);
            sayi--;
          });
        });
      }
      _oncekiSecim = null;
    }
  }

  void _oyunuBitir() {
    setState(() {
      player.stop();
      success.play(AssetSource('sounds/success.mp3'), volume: 0.5);
      _tumKartlarAcildi = true;
      showResult();
    });
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal[100],
        title: Text("congratulations".tr),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              incrementsCandy();
              Navigator.of(context).popUntil((route) => route.isFirst);
              setState(() {
                _kartlariOlustur();
                _acikKartlar.clear();
                _oncekiSecim = null;
                _dogruTahminSayisi = 0;
                _tumKartlarAcildi = false;
              });
            },
            child: Text("okay".tr),
          ),
          TextButton(
            onPressed: () {
              _showRewardedAd();
            },
            child: Text("watch2x".tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        centerTitle: true,
        title: Text('cardgame'.tr, style: baslikStili),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 420,
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisCount: 4,
                children: List.generate(
                  16,
                      (index) => GestureDetector(
                    onTap: () {
                      if (!_tumKartlarAcildi) {
                        _kartAc(index);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _acikKartlar.contains(index)
                            ? Colors.white
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal,
                            offset: Offset(1, 1),
                            blurRadius:
                            _acikKartlar.contains(index) ? 0 : 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: _acikKartlar.contains(index) ||
                            _tumKartlarAcildi
                            ? Image.asset(
                          _kartlar[index],
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        )
                            : Image.asset('assets/card/cardBack2.jpg',fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'time'.tr +':'+ ' ${_counter}'+ ' ' +'second'.tr,
              style: baslikStili,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400],
        child: Icon(Icons.refresh, color: Colors.black,),
        onPressed: () {
          setState(() {
            resetTimer();
            _kartlariOlustur();
            _acikKartlar.clear();
            _oncekiSecim = null;
            _dogruTahminSayisi = 0;
            _tumKartlarAcildi = false;
          });
        },
      ),
    );
  }
}
