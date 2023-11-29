import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pokePages/pokemons.dart';
import 'pokePages/pokeInfoPage.dart';
import 'themeSettings.dart';
import 'package:audioplayers/audioplayers.dart';

int pokeNumber = 1;

class homePage extends StatefulWidget {

  static int point = 0;

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> with WidgetsBindingObserver{
  int seciliIndex = 0;
  int candy = 0;
  int energy = 0;

  final player = AudioPlayer();

  bool hasImage0 = false;
  bool hasImage1 = false;

  void loadData() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      candy = data['candy'];
      energy = data['energy'];
      hasImage0 = data['florass'];
      hasImage1 = data['sparkie'];
      hasImageList[0] = hasImage0;
      hasImageList[1] = hasImage1;
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

  bool isPlaying = false;

  @override
  void initState() {
    loadData();
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

  List<bool> hasImageList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 12, left: 12,right: 12,bottom: 5),
        child: GridView.builder(
          itemCount: 91,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, pokeNumber){
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    if(hasImageList[pokeNumber]==false){
                      unsuccessDialog(context);
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pokeInfoPage(pokeNumber: pokeNumber,)));
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      shape: BoxShape.rectangle,
                      color: Colors.teal[100],
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
                        Text(pokemons.getpokeName(pokeNumber), style: GoogleFonts.robotoSlab(color: Colors.black, fontSize: 14),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            hasImageList[pokeNumber]
                                ? Icon(Icons.check, color: Colors.green,size: 16,)
                                : Icon(Icons.close, color: Colors.red,size: 16,),
                            Text('#'+pokemons.getpokeId(pokeNumber), style: metinStili,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void unsuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text("error".tr),
          content: Text('youneedtobuy'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('okay'.tr),
            ),
          ],
        );
      },
    );
  }

  PreferredSize _appBar(){
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
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
                child: Row(
                  children: [
                    Container(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('hintenergy'.tr),
                            ),
                          );
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Icon(Icons.question_mark, size: 20,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('MonsDex', style: baslikStili),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () {
                          // burada tıklama işlemini belirtin, örneğin bir SnackBar gösterin
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('hintcandy'.tr),
                            ),
                          );
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Icon(Icons.question_mark, size: 20,),
                        ),
                      ),
                    ),
                    Container(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
