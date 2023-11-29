import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/contactus.dart';
import 'package:pokedex/themeSettings.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

import 'login/loginPage.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with WidgetsBindingObserver{

  final player = AudioPlayer();
  final player1 = AudioPlayer();
  bool isPlaying = false;

  String email = '';
  List<Map<String, dynamic>> _fighters = [
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
    {'selected': false},
  ];
  int energy = 0;
  int candy = 0;

  void getPokeData() async{

    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      email = data['email'];
      energy = data['energy'];
      candy = data['candy'];
    });

    setState(() {
      _fighters[0]['selected'] = data['florass'];
      _fighters[1]['selected'] = data['sparkie'];
      _fighters[2]['selected'] = data['sparken'];
      _fighters[3]['selected'] = data['aquadra'];
      _fighters[4]['selected'] = data['shockwing'];
      _fighters[5]['selected'] = data['zapwing'];
      _fighters[6]['selected'] = data['joltur'];
      _fighters[7]['selected'] = data['joltrik'];
      _fighters[8]['selected'] = data['mysticon'];
      _fighters[9]['selected'] = data['psypup'];
      _fighters[10]['selected'] = data['psydog'];
      _fighters[11]['selected'] = data['dolphineon'];
      _fighters[12]['selected'] = data['rockslide'];
      _fighters[13]['selected'] = data['rockfist'];
      _fighters[14]['selected'] = data['silentpaw'];
      _fighters[15]['selected'] = data['shadowclaw'];
      _fighters[16]['selected'] = data['electromon'];
      _fighters[17]['selected'] = data['eaglestorm'];
      _fighters[18]['selected'] = data['skywing'];
      _fighters[19]['selected'] = data['woolie'];
      _fighters[20]['selected'] = data['wooliec'];
      _fighters[21]['selected'] = data['wooliectra'];
      _fighters[22]['selected'] = data['spookums'];
      _fighters[23]['selected'] = data['spookram'];
      _fighters[24]['selected'] = data['nimowl'];
      _fighters[25]['selected'] = data['wisowl'];
      _fighters[26]['selected'] = data['fliefox'];
      _fighters[27]['selected'] = data['fluffox'];
      _fighters[28]['selected'] = data['drogie'];
      _fighters[29]['selected'] = data['drogice'];
      _fighters[30]['selected'] = data['drogrost'];
      _fighters[31]['selected'] = data['monrass'];
      _fighters[32]['selected'] = data['gorrass'];
      _fighters[33]['selected'] = data['flamerock'];
      _fighters[34]['selected'] = data['flameburst'];
      _fighters[35]['selected'] = data['vaseblade'];
      _fighters[36]['selected'] = data['leafblade'];
      _fighters[37]['selected'] = data['forestblade'];
      _fighters[38]['selected'] = data['glimmer'];
      _fighters[39]['selected'] = data['schimmer'];
      _fighters[40]['selected'] = data['dunebelle'];
      _fighters[41]['selected'] = data['infernus'];
      _fighters[42]['selected'] = data['blazenus'];
      _fighters[43]['selected'] = data['whispurr'];
      _fighters[44]['selected'] = data['ghosteroid'];
      _fighters[45]['selected'] = data['toxibug'];
      _fighters[46]['selected'] = data['toxiban'];
      _fighters[47]['selected'] = data['citrusclaw'];
      _fighters[48]['selected'] = data['gingerpaw'];
      _fighters[49]['selected'] = data['poliba'];
      _fighters[50]['selected'] = data['skov'];
      _fighters[51]['selected'] = data['skovie'];
      _fighters[52]['selected'] = data['rhinohorn'];
      _fighters[53]['selected'] = data['rhinorock'];
      _fighters[54]['selected'] = data['seebreeze'];
      _fighters[55]['selected'] = data['seastorm'];
      _fighters[56]['selected'] = data['flamie'];
      _fighters[57]['selected'] = data['flabie'];
      _fighters[58]['selected'] = data['feliphys'];
      _fighters[59]['selected'] = data['mindlion'];
      _fighters[60]['selected'] = data['dracotide'];
      _fighters[61]['selected'] = data['dracoflow'];
      _fighters[62]['selected'] = data['frostbite'];
      _fighters[63]['selected'] = data['frostitoes'];
      _fighters[64]['selected'] = data['minei'];
      _fighters[65]['selected'] = data['minerax'];
      _fighters[66]['selected'] = data['fluffernut'];
      _fighters[67]['selected'] = data['razorleaf'];
      _fighters[68]['selected'] = data['spork'];
      _fighters[69]['selected'] = data['sporkle'];
      _fighters[70]['selected'] = data['zazzle'];
      _fighters[71]['selected'] = data['chiliwrath'];
      _fighters[72]['selected'] = data['chiliclaw'];
      _fighters[73]['selected'] = data['doldog'];
      _fighters[74]['selected'] = data['roseburst'];
      _fighters[75]['selected'] = data['flowerburst'];
      _fighters[76]['selected'] = data['frostie'];
      _fighters[77]['selected'] = data['froster'];
      _fighters[78]['selected'] = data['dolie'];
      _fighters[79]['selected'] = data['dolphie'];
      _fighters[80]['selected'] = data['fenr'];
      _fighters[81]['selected'] = data['fenrago'];
      _fighters[82]['selected'] = data['mindwave'];
      _fighters[83]['selected'] = data['psywave'];
      _fighters[84]['selected'] = data['boolder'];
      _fighters[85]['selected'] = data['boolderback'];
      _fighters[86]['selected'] = data['aquazoid'];
      _fighters[87]['selected'] = data['thunderstrike'];
      _fighters[88]['selected'] = data['bippitibop'];
      _fighters[89]['selected'] = data['venomous'];
      _fighters[90]['selected'] = data['psycodactyl'];
    });

  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    player.play(AssetSource('sounds/background2.mp3'));
    player.setReleaseMode(ReleaseMode.loop);
    isPlaying = true;

    getPokeData();
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

  @override
  Widget build(BuildContext context) {

    final selectedFighters = _fighters.where((fighter) => fighter['selected']).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('profile'.tr, style: baslikStili,),
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.all(12),
                  color: Colors.transparent,
                  child: Image.asset('assets/mos/061.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail),
                Text(email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.electric_bolt),
                Text('$energy' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow,),
                Text('$candy',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.contact_mail_sharp),
                SizedBox(width: 10,),
                Text('${selectedFighters.length}/91',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                  ),
                  onPressed: () async{
                    await player.play(AssetSource('sounds/tap.wav'));
                    Get.updateLocale(Locale("tr","TR"));
                  },
                  child: Text('TÜRKÇE'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                  ),
                  onPressed: () async{
                    await player.play(AssetSource('sounds/tap.wav'));
                    Get.updateLocale(Locale("en","US"));
                  },
                  child: Text('ENGLISH'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                  ),
                  onPressed: () async{
                    await player.play(AssetSource('sounds/tap.wav'));
                    Get.updateLocale(Locale("ar","AR"));
                  },
                  child: Text('ARABIC'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                  ),
                  onPressed: _signOut,
                  child: Text('signout'.tr),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => contactUs()));
                  },
                  child: Text('contactus'.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
