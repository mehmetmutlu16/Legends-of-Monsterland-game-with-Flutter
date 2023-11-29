import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/themeSettings.dart';

void main() {
  runApp(collectionPage());
}

class collectionPage extends StatefulWidget {
  @override
  _collectionPageState createState() => _collectionPageState();
}

class _collectionPageState extends State<collectionPage> with WidgetsBindingObserver{
  String imageFlorass = 'assets/mos/001.png';
  String nameFlorass = 'Florass';
  bool hasFlorass = false;
  String imageSparkie = 'assets/mos/002.png';
  String nameSparkie = 'Sparkie';
  bool hasSparkie = false;
  String imageSparken = 'assets/mos/003.png';
  String nameSparken = 'Sparken';
  bool hasSparken = false;
  String imageAquadra = 'assets/mos/004.png';
  String nameAquadra = 'Aquadra';
  bool hasAquadra = false;
  String imageShockwing = 'assets/mos/005.png';
  String nameShockwing = 'Shockwing';
  bool hasShockwing = false;
  String imageZapwing = 'assets/mos/006.png';
  String nameZapwing = 'Zapwing';
  bool hasZapwing = false;
  String imageJoltur = 'assets/mos/007.png';
  String nameJoltur = 'Joltur';
  bool hasJoltur = false;
  String imageJoltrik = 'assets/mos/008.png';
  String nameJoltrik = 'Joltrik';
  bool hasJoltrik = false;
  String imageMysticon = 'assets/mos/009.png';
  String nameMysticon = 'Mysticon';
  bool hasMysticon = false;
  String imagePsypup = 'assets/mos/010.png';
  String namePsypup = 'Psypup';
  bool hasPsypup = false;
  String imagePsydog = 'assets/mos/011.png';
  String namePsydog = 'Psydog';
  bool hasPsydog = false;
  String imageDolphineon = 'assets/mos/012.png';
  String nameDolphineon = 'Dolphineon';
  bool hasDolphineon = false;
  String imageRockslide = 'assets/mos/013.png';
  String nameRockslide = 'Rockslide';
  bool hasRockslide = false;
  String imageRockfist = 'assets/mos/014.png';
  String nameRockfist = 'Rockfist';
  bool hasRockfist = false;
  String imageSilentpaw = 'assets/mos/015.png';
  String nameSilentpaw = 'Silentpaw';
  bool hasSilentpaw = false;
  String imageShadowclaw = 'assets/mos/016.png';
  String nameShadowclaw = 'Shadowclaw';
  bool hasShadowclaw = false;
  String imageElectromon = 'assets/mos/017.png';
  String nameElectromon = 'Electromon';
  bool hasElectromon = false;
  String imageEaglestorm = 'assets/mos/018.png';
  String nameEaglestorm = 'Eaglestorm';
  bool hasEaglestorm = false;
  String imageSkywing = 'assets/mos/019.png';
  String nameSkywing = 'Skywing';
  bool hasSkywing = false;
  String imageWoolie = 'assets/mos/020.png';
  String nameWoolie = 'Woolie';
  bool hasWoolie = false;
  String imageWooliec = 'assets/mos/021.png';
  String nameWooliec = 'Wooliec';
  bool hasWooliec = false;
  String imageWooliectra = 'assets/mos/022.png';
  String nameWooliectra = 'Wooliectra';
  bool hasWooliectra = false;
  String imageSpookums = 'assets/mos/023.png';
  String nameSpookums = 'Spookums';
  bool hasSpookums = false;
  String imageSpookram = 'assets/mos/024.png';
  String nameSpookram = 'Spookram';
  bool hasSpookram = false;
  String imageNimowl = 'assets/mos/025.png';
  String nameNimowl = 'Nimowl';
  bool hasNimowl = false;
  String imageWisowl = 'assets/mos/026.png';
  String nameWisowl = 'Wisowl';
  bool hasWisowl = false;
  String imageFliefox = 'assets/mos/027.png';
  String nameFliefox = 'Fliefox';
  bool hasFliefox = false;
  String imageFluffox = 'assets/mos/028.png';
  String nameFluffox = 'Fluffox';
  bool hasFluffox = false;
  String imageDrogie = 'assets/mos/029.png';
  String nameDrogie = 'Drogie';
  bool hasDrogie = false;
  String imageDrogice = 'assets/mos/030.png';
  String nameDrogice = 'Drogice';
  bool hasDrogice = false;
  String imageDrogrost = 'assets/mos/031.png';
  String nameDrogrost = 'Drogrost';
  bool hasDrogrost = false;
  String imageMonrass = 'assets/mos/032.png';
  String nameMonrass = 'Monrass';
  bool hasMonrass = false;
  String imageGorrass = 'assets/mos/033.png';
  String nameGorrass = 'Gorrass';
  bool hasGorrass = false;
  String imageFlamerock = 'assets/mos/034.png';
  String nameFlamerock = 'Flamerock';
  bool hasFlamerock = false;
  String imageFlameburst = 'assets/mos/035.png';
  String nameFlameburst = 'Flameburst';
  bool hasFlameburst = false;
  String imageVaseblade = 'assets/mos/036.png';
  String nameVaseblade = 'Vaseblade';
  bool hasVaseblade = false;
  String imageLeafblade = 'assets/mos/037.png';
  String nameLeafblade = 'Leafblade';
  bool hasLeafblade = false;
  String imageForestblade = 'assets/mos/038.png';
  String nameForestblade = 'Forestblade';
  bool hasForestblade = false;
  String imageGlimmer = 'assets/mos/039.png';
  String nameGlimmer = 'Glimmer';
  bool hasGlimmer = false;
  String imageSchimmer = 'assets/mos/040.png';
  String nameSchimmer = 'Schimmer';
  bool hasSchimmer = false;
  String imageDunebelle = 'assets/mos/041.png';
  String nameDunebelle = 'Dunebelle';
  bool hasDunebelle = false;
  String imageInfernus = 'assets/mos/042.png';
  String nameInfernus = 'Infernus';
  bool hasInfernus = false;
  String imageBlazenus = 'assets/mos/043.png';
  String nameBlazenus = 'Blazenus';
  bool hasBlazenus = false;
  String imageWhispurr = 'assets/mos/044.png';
  String nameWhispurr = 'Whispurr';
  bool hasWhispurr = false;
  String imageGhosteroid = 'assets/mos/045.png';
  String nameGhosteroid = 'Ghosteroid';
  bool hasGhosteroid = false;
  String imageToxibug = 'assets/mos/046.png';
  String nameToxibug = 'Toxibug';
  bool hasToxibug = false;
  String imageToxiban = 'assets/mos/047.png';
  String nameToxiban = 'Toxiban';
  bool hasToxiban = false;
  String imageCitrusclaw = 'assets/mos/048.png';
  String nameCitrusclaw = 'Citrusclaw';
  bool hasCitrusclaw = false;
  String imageGingerpaw = 'assets/mos/049.png';
  String nameGingerpaw = 'Gingerpaw';
  bool hasGingerpaw = false;
  String imagePoliba = 'assets/mos/050.png';
  String namePoliba = 'Poliba';
  bool hasPoliba = false;
  String imageSkov = 'assets/mos/051.png';
  String nameSkov = 'Skov';
  bool hasSkov = false;
  String imageSkovie = 'assets/mos/052.png';
  String nameSkovie = 'Skovie';
  bool hasSkovie = false;
  String imageRhinohorn = 'assets/mos/053.png';
  String nameRhinohorn = 'Rhinohorn';
  bool hasRhinohorn = false;
  String imageRhinorock = 'assets/mos/054.png';
  String nameRhinorock = 'Rhinorock';
  bool hasRhinorock = false;
  String imageSeebreeze = 'assets/mos/055.png';
  String nameSeebreeze = 'Seebreeze';
  bool hasSeebreeze = false;
  String imageSeastorm = 'assets/mos/056.png';
  String nameSeastorm = 'Seastorm';
  bool hasSeastorm = false;
  String imageFlamie = 'assets/mos/057.png';
  String nameFlamie = 'Flamie';
  bool hasFlamie = false;
  String imageFlabie = 'assets/mos/058.png';
  String nameFlabie = 'Flabie';
  bool hasFlabie = false;
  String imageFeliphys = 'assets/mos/059.png';
  String nameFeliphys = 'Feliphys';
  bool hasFeliphys = false;
  String imageMindlion = 'assets/mos/060.png';
  String nameMindlion = 'Mindlion';
  bool hasMindlion = false;
  String imageDracotide = 'assets/mos/061.png';
  String nameDracotide = 'Dracotide';
  bool hasDracotide = false;
  String imageDracoflow = 'assets/mos/062.png';
  String nameDracoflow = 'Dracoflow';
  bool hasDracoflow = false;
  String imageFrostbite = 'assets/mos/063.png';
  String nameFrostbite = 'Frostbite';
  bool hasFrostbite = false;
  String imageFrostitoes = 'assets/mos/064.png';
  String nameFrostitoes = 'Frostitoes';
  bool hasFrostitoes = false;
  String imageMinei = 'assets/mos/065.png';
  String nameMinei = 'Minei';
  bool hasMinei = false;
  String imageMinerax = 'assets/mos/066.png';
  String nameMinerax = 'Minerax';
  bool hasMinerax = false;
  String imageFluffernut = 'assets/mos/067.png';
  String nameFluffernut = 'Fluffernut';
  bool hasFluffernut = false;
  String imageRazorleaf = 'assets/mos/068.png';
  String nameRazorleaf = 'Razorleaf';
  bool hasRazorleaf = false;
  String imageSpork = 'assets/mos/069.png';
  String nameSpork = 'Spork';
  bool hasSpork = false;
  String imageSporkle = 'assets/mos/070.png';
  String nameSporkle = 'Sporkle';
  bool hasSporkle = false;
  String imageZazzle = 'assets/mos/071.png';
  String nameZazzle = 'Zazzle';
  bool hasZazzle = false;
  String imageChiliwrath = 'assets/mos/072.png';
  String nameChiliwrath = 'Chiliwrath';
  bool hasChiliwrath = false;
  String imageChiliclaw = 'assets/mos/073.png';
  String nameChiliclaw = 'Chiliclaw';
  bool hasChiliclaw = false;
  String imageDoldog = 'assets/mos/074.png';
  String nameDoldog = 'Doldog';
  bool hasDoldog = false;
  String imageRoseburst = 'assets/mos/075.png';
  String nameRoseburst = 'Roseburst';
  bool hasRoseburst = false;
  String imageFlowerburst = 'assets/mos/076.png';
  String nameFlowerburst = 'Flowerburst';
  bool hasFlowerburst = false;
  String imageFrostie = 'assets/mos/077.png';
  String nameFrostie = 'Frostie';
  bool hasFrostie = false;
  String imageFroster = 'assets/mos/078.png';
  String nameFroster = 'Froster';
  bool hasFroster = false;
  String imageDolie = 'assets/mos/079.png';
  String nameDolie = 'Dolie';
  bool hasDolie = false;
  String imageDolphie = 'assets/mos/080.png';
  String nameDolphie = 'Dolphie';
  bool hasDolphie = false;
  String imageFenr = 'assets/mos/081.png';
  String nameFenr = 'Fenr';
  bool hasFenr = false;
  String imageFenrago = 'assets/mos/082.png';
  String nameFenrago = 'Fenrago';
  bool hasFenrago = false;
  String imageMindwave = 'assets/mos/083.png';
  String nameMindwave = 'Mindwave';
  bool hasMindwave = false;
  String imagePsywave = 'assets/mos/084.png';
  String namePsywave = 'Psywave';
  bool hasPsywave = false;
  String imageBoolder = 'assets/mos/085.png';
  String nameBoolder = 'Boolder';
  bool hasBoolder = false;
  String imageBoolderback = 'assets/mos/086.png';
  String nameBoolderback = 'Boolderback';
  bool hasBoolderback = false;
  String imageAquazoid = 'assets/mos/087.png';
  String nameAquazoid = 'Aquazoid';
  bool hasAquazoid = false;
  String imageThunderstrike = 'assets/mos/088.png';
  String nameThunderstrike = 'Thunderstrike';
  bool hasThunderstrike = false;
  String imageBippitibop = 'assets/mos/089.png';
  String nameBippitibop = 'Bippitibop';
  bool hasBippitibop = false;
  String imageVenomous = 'assets/mos/090.png';
  String nameVenomous = 'Venomous';
  bool hasVenomous = false;
  String imagePsycodactyl = 'assets/mos/091.png';
  String namePsycodactyl = 'Psycodactyl';
  bool hasPsycodactyl = false;

  void getPokeData() async{

    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      hasFlorass = data['florass'];
      hasSparkie = data['sparkie'];
      hasSparken = data['sparken'];
      hasAquadra = data['aquadra'];
      hasShockwing = data['shockwing'];
      hasZapwing = data['zapwing'];
      hasJoltur = data['joltur'];
      hasJoltrik = data['joltrik'];
      hasMysticon = data['mysticon'];
      hasPsypup = data['psypup'];
      hasPsydog = data['psydog'];
      hasDolphineon = data['dolphineon'];
      hasRockslide = data['rockslide'];
      hasRockfist = data['rockfist'];
      hasSilentpaw = data['silentpaw'];
      hasShadowclaw = data['shadowclaw'];
      hasElectromon = data['electromon'];
      hasEaglestorm = data['eaglestorm'];
      hasSkywing = data['skywing'];
      hasWoolie = data['woolie'];
      hasWooliec = data['wooliec'];
      hasWooliectra = data['wooliectra'];
      hasSpookums = data['spookums'];
      hasSpookram = data['spookram'];
      hasNimowl = data['nimowl'];
      hasWisowl = data['wisowl'];
      hasFliefox = data['fliefox'];
      hasFluffox = data['fluffox'];
      hasDrogie = data['drogie'];
      hasDrogice = data['drogice'];
      hasDrogrost = data['drogrost'];
      hasMonrass = data['monrass'];
      hasGorrass = data['gorrass'];
      hasFlamerock = data['flamerock'];
      hasFlameburst = data['flameburst'];
      hasVaseblade = data['vaseblade'];
      hasLeafblade = data['leafblade'];
      hasForestblade = data['forestblade'];
      hasGlimmer = data['glimmer'];
      hasSchimmer = data['schimmer'];
      hasDunebelle = data['dunebelle'];
      hasInfernus = data['infernus'];
      hasBlazenus = data['blazenus'];
      hasWhispurr = data['whispurr'];
      hasGhosteroid = data['ghosteroid'];
      hasToxibug = data['toxibug'];
      hasToxiban = data['toxiban'];
      hasCitrusclaw = data['citrusclaw'];
      hasGingerpaw = data['gingerpaw'];
      hasPoliba = data['poliba'];
      hasSkov = data['skov'];
      hasSkovie = data['skovie'];
      hasRhinohorn = data['rhinohorn'];
      hasRhinorock = data['rhinorock'];
      hasSeebreeze = data['seebreeze'];
      hasSeastorm = data['seastorm'];
      hasFlamie = data['flamie'];
      hasFlabie = data['flabie'];
      hasFeliphys = data['feliphys'];
      hasMindlion = data['mindlion'];
      hasDracotide = data['dracotide'];
      hasDracoflow = data['dracoflow'];
      hasFrostbite = data['frostbite'];
      hasFrostitoes = data['frostitoes'];
      hasMinei = data['minei'];
      hasMinerax = data['minerax'];
      hasFluffernut = data['fluffernut'];
      hasRazorleaf = data['razorleaf'];
      hasSpork = data['spork'];
      hasSporkle = data['sporkle'];
      hasZazzle = data['zazzle'];
      hasChiliwrath = data['chiliwrath'];
      hasChiliclaw = data['chiliclaw'];
      hasDoldog = data['doldog'];
      hasRoseburst = data['roseburst'];
      hasFlowerburst = data['flowerburst'];
      hasFrostie = data['frostie'];
      hasFroster = data['froster'];
      hasDolie = data['dolie'];
      hasDolphie = data['dolphie'];
      hasFenr = data['fenr'];
      hasFenrago = data['fenrago'];
      hasMindwave = data['mindwave'];
      hasPsywave = data['psywave'];
      hasBoolder = data['boolder'];
      hasBoolderback = data['boolderback'];
      hasAquazoid = data['aquazoid'];
      hasThunderstrike = data['thunderstrike'];
      hasBippitibop = data['bippitibop'];
      hasVenomous = data['venomous'];
      hasPsycodactyl = data['psycodactyl'];
    });

  }

  final player = AudioPlayer();

  bool isPlaying = false;

  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);
    player.play(AssetSource('sounds/background2.mp3'));
    player.setReleaseMode(ReleaseMode.loop);
    isPlaying = true;

    getPokeData();

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('mycollection'.tr , style: baslikStili,),
          centerTitle: true,
          backgroundColor: Colors.teal[400],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFlorass, imageFlorass,nameFlorass),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSparkie, imageSparkie, nameSparkie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSparken, imageSparken,nameSparken),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasAquadra, imageAquadra,nameAquadra),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasShockwing, imageShockwing, nameShockwing),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasZapwing, imageZapwing,nameZapwing),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasJoltur, imageJoltur,nameJoltur),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasJoltrik, imageJoltrik, nameJoltrik),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasMysticon, imageMysticon,nameMysticon),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasPsypup, imagePsypup,namePsypup),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasPsydog, imagePsydog, namePsydog),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDolphineon, imageDolphineon,nameDolphineon),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasRockslide, imageRockslide,nameRockslide),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasRockfist, imageRockfist, nameRockfist),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSilentpaw, imageSilentpaw,nameSilentpaw),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasShadowclaw, imageShadowclaw,nameShadowclaw),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasElectromon, imageElectromon, nameElectromon),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasEaglestorm, imageEaglestorm,nameEaglestorm),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSkywing, imageSkywing,nameSkywing),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasWoolie, imageWoolie, nameWoolie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasWooliec, imageWooliec,nameWooliec),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasWooliectra, imageWooliectra,nameWooliectra),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSpookums, imageSpookums, nameSpookums),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSpookram, imageSpookram,nameSpookram),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasNimowl, imageNimowl,nameNimowl),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasWisowl, imageWisowl, nameWisowl),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFliefox, imageFliefox,nameFliefox),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFluffox, imageFluffox,nameFluffox),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDrogie, imageDrogie, nameDrogie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDrogice, imageDrogice,nameDrogice),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDrogrost, imageDrogrost,nameDrogrost),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasMonrass, imageMonrass, nameMonrass),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasGorrass, imageGorrass,nameGorrass),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFlamerock, imageFlamerock,nameFlamerock),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFlameburst, imageFlameburst, nameFlameburst),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasVaseblade, imageVaseblade,nameVaseblade),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasLeafblade, imageLeafblade,nameLeafblade),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasForestblade, imageForestblade, nameForestblade),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasGlimmer, imageGlimmer,nameGlimmer),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSchimmer, imageSchimmer,nameSchimmer),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDunebelle, imageDunebelle, nameDunebelle),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasInfernus, imageInfernus,nameInfernus),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasBlazenus, imageBlazenus,nameBlazenus),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasWhispurr, imageWhispurr, nameWhispurr),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasGhosteroid, imageGhosteroid,nameGhosteroid),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasToxibug, imageToxibug,nameToxibug),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasToxiban, imageToxiban, nameToxiban),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasCitrusclaw, imageCitrusclaw,nameCitrusclaw),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasGingerpaw, imageGingerpaw,nameGingerpaw),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasPoliba, imagePoliba, namePoliba),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSkov, imageSkov,nameSkov),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSkovie, imageSkovie,nameSkovie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasRhinohorn, imageRhinohorn, nameRhinohorn),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasRhinorock, imageRhinorock,nameRhinorock),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSeebreeze, imageSeebreeze,nameSeebreeze),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSeastorm, imageSeastorm, nameSeastorm),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFlamie, imageFlamie,nameFlamie),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFlabie, imageFlabie,nameFlabie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFeliphys, imageFeliphys, nameFeliphys),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasMindlion, imageMindlion,nameMindlion),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDracotide, imageDracotide,nameDracotide),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDracoflow, imageDracoflow, nameDracoflow),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFrostbite, imageFrostbite,nameFrostbite),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFrostitoes, imageFrostitoes,nameFrostitoes),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasMinei, imageMinei, nameMinei),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasMinerax, imageMinerax,nameMinerax),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFluffernut, imageFluffernut,nameFluffernut),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasRazorleaf, imageRazorleaf, nameRazorleaf),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSpork, imageSpork,nameSpork),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasSporkle, imageSporkle,nameSporkle),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasZazzle, imageZazzle, nameZazzle),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasChiliwrath, imageChiliwrath,nameChiliwrath),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasChiliclaw, imageChiliclaw,nameChiliclaw),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDoldog, imageDoldog, nameDoldog),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasRoseburst, imageRoseburst,nameRoseburst),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFlowerburst, imageFlowerburst,nameFlowerburst),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFrostie, imageFrostie, nameFrostie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFroster, imageFroster,nameFroster),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDolie, imageDolie,nameDolie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasDolphie, imageDolphie, nameDolphie),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFenr, imageFenr,nameFenr),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasFenrago, imageFenrago,nameFenrago),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasMindwave, imageMindwave, nameMindwave),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasPsywave, imagePsywave,namePsywave),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasBoolder, imageBoolder,nameBoolder),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasBoolderback, imageBoolderback, nameBoolderback),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasAquazoid, imageAquazoid,nameAquazoid),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasThunderstrike, imageThunderstrike,nameThunderstrike),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasBippitibop, imageBippitibop, nameBippitibop),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasVenomous, imageVenomous,nameVenomous),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: myContainer(hasPsycodactyl, imagePsycodactyl,namePsycodactyl),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container myContainer(bool hasImage, String imagePath, String imageName) {
    return Container(
      child: hasImage
          ? Opacity(
        opacity: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageBuild(imagePath),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(imageName),
                lockIcon(hasImage),
              ],
            ),
          ],
        ),
      )
          : Opacity(
        opacity: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageBuild(imagePath),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(imageName),
                lockIcon(hasImage),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image imageBuild(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }

  Widget lockIcon(bool isOpen) {
    if (isOpen) {
      return Icon(Icons.lock_open, color: Colors.green,);
    } else {
      return Icon(Icons.lock, color: Colors.red,);
    }
  }
}