import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pokedex/changeBottomBar.dart';
import 'package:pokedex/themeSettings.dart';
import 'package:audioplayers/audioplayers.dart';


class changePage extends StatefulWidget {
  const changePage({Key? key}) : super(key: key);

  @override
  State<changePage> createState() => _changePageState();
}

class _changePageState extends State<changePage> {

  final player = AudioPlayer();

  int seciliIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: bottomNav(),
        body: Center(
          child: liste[seciliIndex],
        ),
      ),
    );
  }

  GNav bottomNav() {
    return GNav(
      backgroundColor: Colors.teal,
      color: Colors.yellow[300],
      activeColor: Colors.white,
      tabBackgroundColor: Colors.black45,
      gap: 8,
      textStyle: metinStili,
      padding: EdgeInsets.all(16),
      tabs: [
        GButton(icon: Icons.home),
        GButton(icon: Icons.videogame_asset),
        GButton(icon: Icons.shopping_bag),
        GButton(icon: Icons.shield),
        GButton(icon: Icons.shopping_cart),
        GButton(icon: Icons.person),
      ],
      selectedIndex: seciliIndex,
      onTabChange: (index) async{
        await player.play(AssetSource('sounds/tap.wav'));
        setState(() {
          seciliIndex = index;
        });
      },
    );
  }
}
