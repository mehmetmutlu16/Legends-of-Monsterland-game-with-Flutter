import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/bigFight/war.dart';
import 'package:pokedex/themeSettings.dart';
import 'package:get/get.dart';


class chooseWarrior extends StatefulWidget {
  const chooseWarrior({Key? key}) : super(key: key);

  @override
  State<chooseWarrior> createState() => _chooseWarriorState();
}

class _chooseWarriorState extends State<chooseWarrior> {

  List<Map<String, dynamic>> _fighters = [
    {'name': 'Florass', 'image': 'assets/warCards/001-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Sparkie', 'image': 'assets/warCards/002-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Sparken', 'image': 'assets/warCards/003-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Aquadraa', 'image': 'assets/warCards/004-min.png', 'selected': false, 'type': 'water'},
    {'name': 'Shockwing', 'image': 'assets/warCards/005-min.png', 'selected': false, 'type': 'flying'},
    {'name': 'Zapwing', 'image': 'assets/warCards/006-min.png', 'selected': false, 'type': 'flying'},
    {'name': 'Joltur', 'image': 'assets/warCards/007-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Joltrik', 'image': 'assets/warCards/008-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Mysticon', 'image': 'assets/warCards/009-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Psypup', 'image': 'assets/warCards/010-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Psydog', 'image': 'assets/warCards/011-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Dolphineon', 'image': 'assets/warCards/012-min.png', 'selected': false, 'type': 'water'},
    {'name': 'Rockslide', 'image': 'assets/warCards/013-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Rockfist', 'image': 'assets/warCards/014-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Silentpaw', 'image': 'assets/warCards/015-min.png', 'selected': false, 'type': 'fight'},
    {'name': 'Shadowclaw', 'image': 'assets/warCards/016-min.png', 'selected': false, 'type': 'fight'},
    {'name': 'Electromon', 'image': 'assets/warCards/017-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Eaglestorm', 'image': 'assets/warCards/018-min.png', 'selected': false, 'type': 'flying'},
    {'name': 'Skywing', 'image': 'assets/warCards/019-min.png', 'selected': false, 'type': 'flying'},
    {'name': 'Woolie', 'image': 'assets/warCards/020-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Wooliec', 'image': 'assets/warCards/021-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Wooliectra', 'image': 'assets/warCards/022-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Spookums', 'image': 'assets/warCards/023-min.png', 'selected': false, 'type': 'ghost'},
    {'name': 'Spookram', 'image': 'assets/warCards/024-min.png', 'selected': false, 'type': 'ghost'},
    {'name': 'Nimowl', 'image': 'assets/warCards/025-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Wisowl', 'image': 'assets/warCards/026-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Fliefox', 'image': 'assets/warCards/027-min.png', 'selected': false, 'type': 'normal'},
    {'name': 'Fluffox', 'image': 'assets/warCards/028-min.png', 'selected': false, 'type': 'normal'},
    {'name': 'Drogie', 'image': 'assets/warCards/029-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Drogice', 'image': 'assets/warCards/030-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Drogrost', 'image': 'assets/warCards/031-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Monrass', 'image': 'assets/warCards/032-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Gorrass', 'image': 'assets/warCards/033-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Flamerock', 'image': 'assets/warCards/034-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Flameburst', 'image': 'assets/warCards/035-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Vaseblade', 'image': 'assets/warCards/036-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Leafblade', 'image': 'assets/warCards/037-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Forestblade', 'image': 'assets/warCards/038-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Glimmer', 'image': 'assets/warCards/039-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Schimmer', 'image': 'assets/warCards/040-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Dunebelle', 'image': 'assets/warCards/041-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Infernus', 'image': 'assets/warCards/042-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Blazenus', 'image': 'assets/warCards/043-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Whispurr', 'image': 'assets/warCards/044-min.png', 'selected': false, 'type': 'ghost'},
    {'name': 'Ghosteroid', 'image': 'assets/warCards/045-min.png', 'selected': false, 'type': 'ghost'},
    {'name': 'Toxibug', 'image': 'assets/warCards/046-min.png', 'selected': false, 'type': 'bug'},
    {'name': 'Toxiban', 'image': 'assets/warCards/047-min.png', 'selected': false, 'type': 'bug'},
    {'name': 'Citrusclaw', 'image': 'assets/warCards/048-min.png', 'selected': false, 'type': 'normal'},
    {'name': 'Gingerpaw', 'image': 'assets/warCards/049-min.png', 'selected': false, 'type': 'normal'},
    {'name': 'Poliba', 'image': 'assets/warCards/050-min.png', 'selected': false, 'type': 'poison'},
    {'name': 'Skov', 'image': 'assets/warCards/051-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Skovie', 'image': 'assets/warCards/052-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Rhinohorn', 'image': 'assets/warCards/053-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Rhinorock', 'image': 'assets/warCards/054-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Seebreeze', 'image': 'assets/warCards/055-min.png', 'selected': false, 'type': 'water'},
    {'name': 'Seastorm', 'image': 'assets/warCards/056-min.png', 'selected': false, 'type': 'water'},
    {'name': 'Flamie', 'image': 'assets/warCards/057-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Flabie', 'image': 'assets/warCards/058-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Feliphys', 'image': 'assets/warCards/059-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Mindlion', 'image': 'assets/warCards/060-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Dracotide', 'image': 'assets/warCards/061-min.png', 'selected': false,'type': 'dragon'},
    {'name': 'Dracoflow', 'image': 'assets/warCards/062-min.png', 'selected': false, 'type': 'dragon'},
    {'name': 'Frostbite', 'image': 'assets/warCards/063-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Frostitoes', 'image': 'assets/warCards/064-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Minei', 'image': 'assets/warCards/065-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Minerax', 'image': 'assets/warCards/066-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Fluffernut', 'image': 'assets/warCards/067-min.png', 'selected': false,'type': 'grass'},
    {'name': 'Razorleaf', 'image': 'assets/warCards/068-min.png', 'selected': false,'type': 'grass'},
    {'name': 'Spork', 'image': 'assets/warCards/069-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Sporkle', 'image': 'assets/warCards/070-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Zazzle', 'image': 'assets/warCards/071-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Chiliwrath', 'image': 'assets/warCards/072-min.png', 'selected': false, 'type': 'fire'},
    {'name': 'Chiliclaw', 'image': 'assets/warCards/073-min.png', 'selected': false,'type': 'fire'},
    {'name': 'Doldog', 'image': 'assets/warCards/074-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Roseburst', 'image': 'assets/warCards/075-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Flowerburst', 'image': 'assets/warCards/076-min.png', 'selected': false, 'type': 'grass'},
    {'name': 'Frostie', 'image': 'assets/warCards/077-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Froster', 'image': 'assets/warCards/078-min.png', 'selected': false, 'type': 'ice'},
    {'name': 'Dolie', 'image': 'assets/warCards/079-min.png', 'selected': false, 'type': 'water'},
    {'name': 'Dolphie', 'image': 'assets/warCards/080-min.png', 'selected': false , 'type': 'water'},
    {'name': 'Fenr', 'image': 'assets/warCards/081-min.png', 'selected': false, 'type': 'dragon'},
    {'name': 'Fenrago', 'image': 'assets/warCards/082-min.png', 'selected': false, 'type': 'dragon'},
    {'name': 'Mindwave', 'image': 'assets/warCards/083-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Psywave', 'image': 'assets/warCards/084-min.png', 'selected': false, 'type': 'psychic'},
    {'name': 'Boolder', 'image': 'assets/warCards/085-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Boolderback', 'image': 'assets/warCards/086-min.png', 'selected': false, 'type': 'rock'},
    {'name': 'Aquazoid', 'image': 'assets/warCards/087-min.png', 'selected': false, 'type': 'water'},
    {'name': 'Thunderstrike', 'image': 'assets/warCards/088-min.png', 'selected': false, 'type': 'electric'},
    {'name': 'Bippitibop', 'image': 'assets/warCards/089-min.png', 'selected': false, 'type': 'ghost'},
    {'name': 'Venomous', 'image': 'assets/warCards/090-min.png', 'selected': false, 'type': 'poison'},
    {'name': 'Psycodactyl', 'image': 'assets/warCards/091-min.png', 'selected': false, 'type': 'dragon'},
  ];

  late var data;

  void getPokeData() async {
    var user = FirebaseAuth.instance.currentUser;
    data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

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

  @override
  void initState() {
    loadData();
    getPokeData();
    super.initState();
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
      candy = data['candy'];
      energy = data['energy'];
    });
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

  @override
  Widget build(BuildContext context) {
    final selectedFighters = _fighters.where((fighter) => fighter['selected']).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('selectfighter'.tr, style: baslikStili,),
        backgroundColor: Colors.teal[400],
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
        children: List.generate(selectedFighters.length, (index) {
          return GestureDetector(
            onTap: (){
              decreaseEnergy();
              print(selectedFighters);
              Navigator.push(context, MaterialPageRoute(builder: (context) => warPage(selectedFighters[index]['image'], selectedFighters[index]['type'], selectedFighters[index]['name'])));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    selectedFighters[index]['image'],
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
