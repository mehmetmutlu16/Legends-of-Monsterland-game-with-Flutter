import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../changePage.dart';
import '../gameChoose.dart';

class tetris extends StatefulWidget {
  const tetris({Key? key}) : super(key: key);

  @override
  State<tetris> createState() => _tetrisState();
}

class _tetrisState extends State<tetris> {

  GlobalKey<_TetrisWidgetState> keyGlobal = GlobalKey();

  ValueNotifier<List<BrickObjectPos>> brickObjectPosValue = ValueNotifier<List<BrickObjectPos>>(List<BrickObjectPos>.from([]));

  ValueNotifier<Scoring> scoring = ValueNotifier<Scoring>(new Scoring());

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

  void initState(){
    _loadRewardedAd();
    loadData();
    super.initState();
  }

  void _showGameOverDialog(int score) {
    int winnings = (score/1000).toInt();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal[100],
        title: Text('Dialog'),
        content: Text('withdraw'.tr + ' ${(score/1000).toInt()} Candy'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('no'.tr),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              for(int i=0; i<winnings;i++){
                incrementsCandy();
              }
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => changePage()),
                    (route) => false,
              );
            },
            child: Text('yes'.tr),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              _showRewardedAd(2*winnings);
            },
            child: Text('watch2x'.tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int score = 0;
    const double sizePerSquare = 40;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: Colors.teal,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints){
                return Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: constraints.biggest.width/2,
                            //color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Monster Tetris'),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: scoring,
                                  builder: (context,Scoring value , child) {
                                    score = value.score;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Score : ${value.score}'),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                                          ),
                                          onPressed: (){
                                            keyGlobal.currentState!.resetGame();
                                          },
                                          child: Text('start'.tr, style: TextStyle(color: Colors.black, fontSize: 10),),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                                          ),
                                          onPressed: (){
                                            keyGlobal.currentState!.pauseGame();
                                          },
                                          child: Text('pause'.tr, style: TextStyle(color: Colors.black, fontSize: 10),),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow)
                                          ),
                                          onPressed: (){
                                            _showGameOverDialog(score);
                                          },
                                          child: Text('end'.tr, style: TextStyle(color: Colors.black, fontSize: 10),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: constraints.biggest.width/2,
                            color: Colors.yellow,
                            child: Column(
                              children: [
                                Text('next'.tr + ': '),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                  child: ValueListenableBuilder(
                                    valueListenable: brickObjectPosValue,
                                    builder: (context, List<BrickObjectPos> value,child){
                                      BrickShapeEnum tempShapeEnum =
                                      value.length > 0
                                          ? value.last.shapeEnum
                                          : BrickShapeEnum.Line;
                                      int rotation = value.length > 0
                                          ? value.last.rotation
                                          :0;
                                      return BrickShape(
                                        BrickShapeStatic.getListBrickEnum(
                                          tempShapeEnum,
                                          direction: rotation,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      color: Colors.green,
                      child: LayoutBuilder(builder: (context,constraints){
                        return TetrisWidget(
                          constraints.biggest,
                          key: keyGlobal,
                          sizePerSquare: sizePerSquare,
                          setCallbackScore: (Scoring score){
                            this.scoring.value = score;
                            this.scoring.notifyListeners();
                          },
                          setNextBrick:
                              (List<BrickObjectPos> brickObjectPos){
                            brickObjectPosValue.value = brickObjectPos;
                            brickObjectPosValue.notifyListeners();
                          },
                        );
                      }),
                    ),
                    ),
                    Container(
                      color: Colors.teal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => keyGlobal.currentState!
                                .transformBrick(move: Offset(-sizePerSquare, 0)),
                            child: Icon(Icons.arrow_back_sharp),
                          ), // Elevated Button
                          ElevatedButton(
                            onPressed: () => keyGlobal.currentState!
                                .transformBrick(move: Offset(sizePerSquare, 0)),
                            child: Icon(Icons.arrow_forward_sharp),
                          ), // ElevatedButton
                          ElevatedButton(
                            onPressed: () => keyGlobal.currentState!
                                .transformBrick(move: Offset(0, sizePerSquare)),
                            child: Text("boost".tr),
                          ), // ElevatedButton
                          ElevatedButton(
                            onPressed: () => keyGlobal.currentState!
                                .transformBrick(rotate: true),
                            child: Text("rotate".tr),
                          ) // Elevated Button
                        ],
                      ), // Row
                    ) // Container
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Scoring{
  int score;
  int level;
  int lineDestroy;

  Scoring({this.score = 0,this.level = 1,this.lineDestroy = 1});

  void calcScore({int line: 1}){
    final player2 = AudioPlayer();

    int sum;
    this.setLineDestroy(line);

    if(line==1){
      player2.play(AssetSource('sounds/tetrisline.mp3'), volume: 0.5);
      sum = 100 * (level);
    }else if(line == 1){
      player2.play(AssetSource('sounds/tetrisline.mp3'), volume: 0.5);
      sum = 100 * (level);
    }else if(line == 1){
      player2.play(AssetSource('sounds/tetrisline.mp3'), volume: 0.5);
      sum = 100 * (level);
    }else{
      player2.play(AssetSource('sounds/tetrisline.mp3'), volume: 0.5);
      sum = 100 * (level);
    }
    this.score += sum;
  }

  void setLineDestroy(int line){
    this.lineDestroy = line;
    this.level = (this.lineDestroy~/10)+1;
  }

  void resetScore(){
    this.level=1;
    this.lineDestroy=0;
    this.score=0;
  }

}

class TetrisWidget extends StatefulWidget {

  final Size size;
  final double? sizePerSquare;
  Function(Scoring score)? setCallbackScore;

  Function(List<BrickObjectPos> brickObjectPos)? setNextBrick;
  TetrisWidget(this.size, {Key? key, this.setNextBrick, this.sizePerSquare,this.setCallbackScore}) : super(key: key);

  @override
  State<TetrisWidget> createState() => _TetrisWidgetState();
}

class _TetrisWidgetState extends State<TetrisWidget> with SingleTickerProviderStateMixin {

  final player = AudioPlayer();

  late int candy;

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


  late Animation<double> animation;
  late AnimationController animationController;

  late Size sizeBox;

  late List<int> levelBases;

  ValueNotifier<List<BrickObjectPos>> brickObjectPosValue = ValueNotifier<List<BrickObjectPos>>([]);
  ValueNotifier<List<BrickObjectPosDone>> donePointsValue = ValueNotifier<List<BrickObjectPosDone>>([]);
  ValueNotifier<int> animationPosTickValue = ValueNotifier<int>(0);

  ValueNotifier<Scoring> scoring = ValueNotifier<Scoring>(new Scoring());

  @override
  void initState() {
    _loadRewardedAd();

    loadData();

    super.initState();

    calculateSizeBox();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(animationLoop);

    animationController.forward();
  }

  calculateSizeBox(){
    sizeBox = Size(
      (widget.size.width ~/ widget.sizePerSquare!)*widget.sizePerSquare!,
      (widget.size.height ~/ widget.sizePerSquare!)*widget.sizePerSquare!,
    );

    levelBases = List.generate(sizeBox.width ~/ widget.sizePerSquare!, (index){
      return (((sizeBox.height ~/ widget.sizePerSquare!)-1)* (sizeBox.width ~/ widget.sizePerSquare!)) +index;
    });

    levelBases
        .addAll(List.generate(sizeBox.height ~/widget.sizePerSquare!, (index) {
      return index* (sizeBox.width ~/ widget.sizePerSquare!);
    }));

    levelBases
        .addAll(List.generate(sizeBox.height ~/ widget.sizePerSquare!, (index) {
      return (index* (sizeBox.width ~/widget.sizePerSquare!)) +
          (sizeBox.width ~/widget.sizePerSquare! - 1);
    }));
  }

  pauseGame() async {
    animationController.stop();
    player.pause();
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          Center(child: Text("pausegame".tr)),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
            animationController.forward();
            player.resume();
          },
              child: Text("resume".tr))
        ],
      ), // SimpleDialog
    );
  }

  resetGame() async {
    animationController.stop();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        children: [
          Text("Reset Game"),
          ElevatedButton(
            onPressed: () {
              player.play(AssetSource('sounds/tetris.mp3'), volume: 0.5);
              player.setReleaseMode(ReleaseMode.loop);

              donePointsValue.value = [];
              donePointsValue.notifyListeners();

              brickObjectPosValue.value = [];
              brickObjectPosValue.notifyListeners();

              this.scoring.value.resetScore();
              this.widget.setCallbackScore?.call(this.scoring.value);
              this.scoring.notifyListeners();

              Navigator.of(context).pop();

              calculateSizeBox();
              randomBrick(start: true);
              animationController.reset();
              animationController.stop();
              animationController.forward();
            },
            child: Text("start".tr + "/ Reset"),), // Elevated Button
        ],
      ), // SimpleDialog
    );
  }

  animationLoop() async {
    if(animation.isCompleted && brickObjectPosValue.value.length > 1){

      BrickObjectPos currentObj = brickObjectPosValue.value[brickObjectPosValue.value.length-2];

      Offset target = currentObj.offset.translate(0, widget.sizePerSquare!);

      if(checkTargetMove(target, currentObj)){
        currentObj.offset = target;
        currentObj.calculateHit();
        brickObjectPosValue.notifyListeners();
      }else{
        currentObj.pointArray
            .where((element) => element != -99999)
            .toList()
            .forEach((element) {
          donePointsValue.value
              .add(BrickObjectPosDone(element, color: currentObj.color));
        });

        donePointsValue.notifyListeners();

        brickObjectPosValue.value
            .removeAt(brickObjectPosValue.value.length -2);

        await checkCompleteLine();

        bool status = await checkGameOver();

        if(!status){
          randomBrick();
        }else{
          show();
          print('bitti');
        }
      }

      animationController.reset();
      animationController.forward();
    }
  }

  Future<bool> checkGameOver() async{
    return donePointsValue.value.where((element) => element.index < 0 && element.index != -99999).length > 0;
  }

  checkCompleteLine() async{
    List<int> leftIndex =
    List.generate(sizeBox.height ~/widget.sizePerSquare!, (index) {
      return index * ((sizeBox.width ~/ widget.sizePerSquare!));
    });
    int totalCol = (sizeBox.width ~/widget.sizePerSquare!) - 2;
    List<int> lineDestroys = leftIndex.where((element) {
      return donePointsValue.value
          .where((point) => point.index == element + 1)
          .length > 0;
    }).where((donePoint) {
      List<int> rows=
      List.generate(totalCol, (index) => donePoint + 1 + index).toList();
      return rows.where((row) {
        return donePointsValue.value
            .where((element) => element.index == row)
            .length > 0;
      }).length ==
          rows.length;
    }).toList();

    int lineDestroy = lineDestroys.length;

        lineDestroys = lineDestroys.map((e){
      return List.generate(totalCol, (index) => e + 1 + index).toList();
    })
        .expand((element) => element)
        .toList();

    List<BrickObjectPosDone> tempDonePoints = donePointsValue.value;

    if (lineDestroys.length > 0) {

      this.scoring.value.calcScore(line: lineDestroys.length);
      this.scoring.notifyListeners();
      widget.setCallbackScore?.call(this.scoring.value);

      lineDestroys.sort((a, b) => a.compareTo(b));
      tempDonePoints.sort((a, b) => a.index.compareTo (b.index));
      int firstIndex = tempDonePoints
          .indexWhere((element) => element.index == lineDestroys.first);
      if (firstIndex >= 0) {
        tempDonePoints.removeWhere((element) {
          return lineDestroys.where((line) => line == element.index).length >
              0;
        });
        donePointsValue.value = tempDonePoints.map((element) {
          if (element.index < lineDestroys.first) {
            int totalRowDelete = lineDestroys.length ~/ totalCol;
            element.index = element.index + ((totalCol + 2) * totalRowDelete);
          }
          return element;
        }).toList();
        donePointsValue.notifyListeners();
      }
    }
  }

  bool checkTargetMove(Offset targetPos, BrickObjectPos object){
    List<int> pointsPredict = object.calculateHit(predict: targetPos);

    List<int> hitsIndex = [];

    hitsIndex.addAll(levelBases);

    hitsIndex.addAll(donePointsValue.value.map((e) => e.index));

    int numberHitBase = pointsPredict
        .map((e) => hitsIndex.indexWhere((element) => element == e) > -1)
        .where((element) => element)
        .length;

    return numberHitBase == 0;
  }

  void show(){
    player.stop();
    final player3 = AudioPlayer();
    player3.play(AssetSource('sounds/gameover.mp3'), volume:0.5);
    int winnings = ((scoring.value.score)/1000).toInt();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.teal[100],
            title: Center(
              child: Text(
                'gameover'.tr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            content: Text('Score: ${scoring.value.score}'),
            actions: [
              GestureDetector(
                onTap: (){
                  _showRewardedAd(2*winnings);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'adsfor'.tr +': ${2*winnings} candy',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  for(int i=0; i<winnings;i++){
                    incrementsCandy();
                  }
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => changePage()),
                        (route) => false,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      '$winnings candy',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  resetGame2(){
    animationController.stop();

    donePointsValue.value = [];
    donePointsValue.notifyListeners();

    brickObjectPosValue.value = [];
    brickObjectPosValue.notifyListeners();

    this.scoring.value.resetScore();
    this.widget.setCallbackScore?.call(this.scoring.value);
    this.scoring.notifyListeners();

    Navigator.of(context).pop();

    calculateSizeBox();
    randomBrick(start: true);
    animationController.reset();
    animationController.stop();
    animationController.forward();

  }

  randomBrick({start: false,}){
    brickObjectPosValue.value.add(getNewBrickPos());

    if(start){
      brickObjectPosValue.value.add(getNewBrickPos());
    }
    widget.setNextBrick!.call(brickObjectPosValue.value);
    brickObjectPosValue.notifyListeners();
  }

  BrickObjectPos getNewBrickPos() {
    return new BrickObjectPos(
      size: Size.square(widget.sizePerSquare!),
      sizeLayout: sizeBox,
      color: Colors.primaries [Random().nextInt(Colors.primaries.length)].shade800,
      rotation: Random().nextInt(4),
      offset: Offset(widget.sizePerSquare! * 4, -widget.sizePerSquare! * 3),
      shapeEnum: BrickShapeEnum.values [Random().nextInt(BrickShapeEnum.values.length)],
    );
  }// BrickObjectPos


  @override
  void dispose(){
    player.stop();
    animation.removeListener(animationLoop);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Color? myColor = Colors.teal; // nullable Color türünden bir değişken

    double margin = 0;
    Border border = Border.all(width: 1,color: Colors.black);
    return Container(
        alignment: Alignment.center,
        color: Colors.teal,
        child: Container(
          color: Colors.grey[500],
          child: Container(
            width: sizeBox.width,
            height: sizeBox.height,
            child: ValueListenableBuilder(
              valueListenable: donePointsValue,
              builder: (context, List<BrickObjectPosDone> donePoints, child) {
                return ValueListenableBuilder(
                  valueListenable: brickObjectPosValue,
                  builder: (context, List<BrickObjectPos> brickObjectPoses, child) {
                    return Stack(
                      children: [
                        ...List.generate(
                            sizeBox.width ~/
                                widget.sizePerSquare! *
                                sizeBox.height ~/
                                widget.sizePerSquare!, (index){
                          return Positioned(
                            left: index % (sizeBox.width/widget.sizePerSquare!) * widget.sizePerSquare!,
                            top : index ~/ (sizeBox.width / widget.sizePerSquare!) * widget.sizePerSquare!,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: checkIndexHitBase(index)
                                    ? Colors.black87
                                    : Colors.transparent,
                                border: Border.all(width: 0.6, color: Colors.black87),
                              ),
                              width: widget.sizePerSquare!,
                              height: widget.sizePerSquare!,
                              child: Text(''),
                            ),
                          );
                        }).toList(),
                        if(brickObjectPoses.length>1)
                          ...brickObjectPoses
                              .where((element) => !element.isDone)
                              .toList()
                              .asMap()
                              .entries
                              .map((e) => Positioned(
                            left: e.value.offset.dx,
                            top: e.value.offset.dy,
                            child: BrickShape(
                              BrickShapeStatic.getListBrickEnum(
                                e.value.shapeEnum,
                                direction: e.value.rotation,
                              ),
                              sizePerSquare: widget.sizePerSquare!,
                              points: e.value.pointArray,
                              color: e.value.color,
                            ),
                          ),
                          ).toList(),

                        if(donePoints.length > 0)
                          ...donePoints.map((e) => Positioned(
                            left: e.index % (sizeBox.width / widget.sizePerSquare!)*widget.sizePerSquare!,
                            top: (e.index ~/ (sizeBox.width / widget.sizePerSquare!) * widget.sizePerSquare!).toDouble(),
                            child: Container(
                              width: widget.sizePerSquare!,
                              height: widget.sizePerSquare!,

                              child: boxBrick(myColor, text: e.index),
                            ),
                          ))
                      ],
                    ); // Stack
                  },
                ); // ValueListenableBuilder
              },
            ), // ValueListenableBuilder
          ),
        )
    );
  }

  checkIndexHitBase(int index){
    return levelBases.indexWhere((element) => element == index) != -1;
  }

  transformBrick({Offset? move, bool? rotate}){
    if(move!=null || rotate != null){
      BrickObjectPos currentObj = brickObjectPosValue.value[brickObjectPosValue.value.length-2];

      late Offset target;
      if(move!=null){
        target = currentObj.offset.translate(move.dx, move.dy);

        if(checkTargetMove(target, currentObj)){
          currentObj.offset = target;
          currentObj.calculateHit();
          brickObjectPosValue.notifyListeners();
        }
      }else{
        //BrickObjectPos tempCurrent = BrickObjectPos.clone(currentObj);
        currentObj.calculateRotation(1);

        if(checkTargetMove(currentObj.offset, currentObj)){
          currentObj.calculateHit();
          brickObjectPosValue.notifyListeners();
        }else{
          currentObj.calculateRotation(-1);
        }

      }
    }
  }
}


enum BrickShapeEnum{Square, LShape, RLShape,ZigZag, RZigZag, TShape, Line}

class BrickShapeStatic{
  static List<List<List<double>>> rotateLShape = [
    [
      [0,0,1],
      [1,1,1],
      [0,0,0],
    ],
    [
      [0,1,0],
      [0,1,0],
      [0,1,1],
    ],
    [
      [0,0,0],
      [1,1,1],
      [1,0,0],
    ],
    [
      [1,1,0],
      [0,1,0],
      [0,1,0],
    ],
  ];
  static List<List<List<double>>> rotateRLShape = [
    [
      [1,0,0],
      [1,1,1],
      [0,0,0],
    ],
    [
      [0,1,1],
      [0,1,0],
      [0,1,0],
    ],
    [
      [0,0,0],
      [1,1,1],
      [0,0,1],
    ],
    [
      [0,1,0],
      [0,1,0],
      [1,1,0],
    ],
  ];
  static List<List<List<double>>> rotateZigZag = [
    [
      [0,0,0],
      [1,1,0],
      [0,1,1],
    ],
    [
      [0,1,0],
      [1,1,0],
      [1,0,0],
    ],
    [
      [0,0,0],
      [1,1,0],
      [0,1,1],
    ],
    [
      [0,1,0],
      [1,1,0],
      [1,0,0],
    ],
  ];
  static List<List<List<double>>> rotateRZigZag = [
    [
      [0,0,0],
      [0,1,1],
      [1,1,0],
    ],
    [
      [1,0,0],
      [1,1,0],
      [0,1,0],
    ],
    [
      [0,0,0],
      [0,1,1],
      [1,1,0],
    ],
    [
      [1,0,0],
      [1,1,0],
      [0,1,0],
    ],
  ];
  static List<List<List<double>>> rotateTShape = [
    [
      [0,1,0],
      [1,1,1],
      [0,0,0],
    ],
    [
      [0,1,0],
      [0,1,1],
      [0,1,0],
    ],
    [
      [0,0,0],
      [1,1,1],
      [0,1,0],
    ],
    [
      [0,1,0],
      [1,1,0],
      [0,1,0],
    ],
  ];
  static List<List<List<double>>> rotateLine = [
    [
      [0,0,0,0],
      [1,1,1,1],
      [0,0,0,0],
      [0,0,0,0],
    ],
    [
      [0,1,0,0],
      [0,1,0,0],
      [0,1,0,0],
      [0,1,0,0],
    ],
    [
      [0,0,0,0],
      [1,1,1,1],
      [0,0,0,0],
      [0,0,0,0],
    ],
    [
      [0,1,0,0],
      [0,1,0,0],
      [0,1,0,0],
      [0,1,0,0],
    ],
  ];


  static List<List<double>> getListBrickEnum(BrickShapeEnum shapeEnum,{int direction:0}){
    List<List<double>> shapeList;

    if (shapeEnum == BrickShapeEnum.Square)
      shapeList = [
        [1, 1],
        [1, 1]
      ];
    else if (shapeEnum == BrickShapeEnum.LShape)
      shapeList = rotateLShape[direction%4];
    else if (shapeEnum == BrickShapeEnum.RLShape)
      shapeList = rotateRLShape[direction%4];
    else if (shapeEnum == BrickShapeEnum. ZigZag)
      shapeList = rotateZigZag[direction%4];
    else if (shapeEnum == BrickShapeEnum.RZigZag)
      shapeList = rotateRZigZag[direction%4];
    else if (shapeEnum == BrickShapeEnum. TShape)
      shapeList = rotateTShape[direction%4];
    else if (shapeEnum == BrickShapeEnum.Line)
      shapeList = rotateLine[direction%4];
    else
      shapeList = [];

    return shapeList;
  }
}



class BrickObject{
  bool enable;
  BrickObject({this.enable = false});
}

class BrickObjectPosDone{
  Colors? color;
  int index;

  BrickObjectPosDone(this.index, {color: Colors.green});
}

class BrickObjectPos{
  Offset offset;
  BrickShapeEnum shapeEnum;
  int rotation;
  bool isDone;
  Size? sizeLayout;
  Size? size;
  List<int> pointArray = [];
  Color color;

  static clone(BrickObjectPos object){
    return new BrickObjectPos(
      offset: object.offset,
      shapeEnum: object.shapeEnum,
      rotation: object.rotation,
      isDone: object.isDone,
      sizeLayout: object.sizeLayout,
      size: object.size,
      color: object.color,
    );

  }

  BrickObjectPos({
    this.size,
    this.sizeLayout,
    this.isDone: false,
    this.offset: Offset.zero,
    this.shapeEnum: BrickShapeEnum.Line,
    this.rotation: 0,
    this.color: Colors.amber,
  }){
    calculateHit();
  }

  setShape(BrickShapeEnum shapeEnum){
    this.shapeEnum = shapeEnum;
    calculateHit();
  }

  calculateRotation(int flag){
    this.rotation += flag;
    calculateHit();
  }

  calculateHit({Offset? predict}){
    List<int> lists = BrickShapeStatic.getListBrickEnum(this.shapeEnum,direction: this.rotation).expand((element) => element).map((e) => e.toInt()).toList();
    List<int> tempPoint = lists.asMap().entries.map((e) => calculateOffset(e,lists.length, predict != null ? predict :this.offset)).toList();

    if(predict != null){
      return tempPoint;
    }
    else{
      this.pointArray = tempPoint;
    }
  }

  int calculateOffset(MapEntry<int, int> entry, int length, Offset offsetTemp){
    int value = entry.value;

    if(this.size != null){
      if(value==0){
        value = -99999;
      }
      else{
        double left = offsetTemp.dx / this.size!.width + entry.key %  sqrt(length);
        double top = offsetTemp.dy / this.size!.width + entry.key ~/ sqrt(length);

        int index = left.toInt() + (top * (this.sizeLayout!.width / size!.width)).toInt();

        value = (index).toInt();
      }
    }
    return value;
  }
}

class BrickShape extends StatefulWidget {
  List<List<double>> list;
  List? points;
  double sizePerSquare;
  Color? color;

  BrickShape(this.list ,{Key? key, this.color,this.points,this.sizePerSquare: 20}) : super(key: key);

  @override
  State<BrickShape> createState() => _BrickShapeState();
}

class _BrickShapeState extends State<BrickShape> {
  @override
  Widget build(BuildContext context) {

    int totalPointList = widget.list.expand((element) => element).length;

    int columnNum = (totalPointList ~/ widget.list.length);

    return Container(
      width: widget.sizePerSquare*columnNum,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: totalPointList,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columnNum,childAspectRatio: 1),
        itemBuilder: (context, index){
          return Offstage(
            offstage: widget.list.expand((element) => element).toList()[index] == 0,
            child: boxBrick(widget.color ?? Colors.cyan, text: widget.points?[index] ?? ''),
          );
        },
      ),
    );
  }
}

Widget boxBrick(Color color, {text: ''}){
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width:1),
    ),
  );
}