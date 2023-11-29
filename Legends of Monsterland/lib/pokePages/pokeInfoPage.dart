import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/pokePages/pokeHealth.dart';
import 'package:pokedex/pokePages/pokePower.dart';
import 'package:pokedex/pokePages/pokeSpeed.dart';
import 'package:pokedex/themeSettings.dart';
import 'pokemons.dart';

class pokeInfoPage extends StatelessWidget {

  int pokeNumber;

  pokeInfoPage({required this.pokeNumber});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: Center(
            child: Text(pokemons.getpokeName(pokeNumber), style: baslikStili,),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          shape: BoxShape.rectangle,
                          color: Colors.teal[100],
                        ),
                        width: 200,
                        height: 180,
                        child: Image.asset(pokemonlar[pokeNumber].image),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('poketype'.tr, style: icerikStili,),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pokeTipi1(pokeNumber),
                              SizedBox(
                                width: 10,
                              ),
                              tip2Kontrol(pokeNumber),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('weakness'.tr, style: icerikStili,),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pokeWeakness1(pokeNumber),
                              SizedBox(
                                width: 10,
                              ),
                              pokeWeakness2(pokeNumber),
                              SizedBox(
                                width: 10,
                              ),
                              weakness3Kontrol(pokeNumber),
                              SizedBox(
                                width: 10,
                              ),
                              weakness4Kontrol(pokeNumber),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('power'.tr, style: icerikStili,),
                      Row(
                        children: [
                          Expanded(
                            child: pokePower(pokeNumber),
                          ),
                        ],
                      ),
                      Text('speed'.tr, style: icerikStili,),
                      Row(
                        children: [
                          Expanded(
                            child: pokeSpeed(pokeNumber),
                          ),
                        ],
                      ),
                      Text('health2'.tr, style: icerikStili,),
                      Row(
                        children: [
                          Expanded(
                            child: pokeHealth(pokeNumber),
                          ),
                        ],
                      ),
                      Text('evolve'.tr, style: icerikStili,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                shape: BoxShape.rectangle,
                                color: Colors.teal[100],
                              ),
                              child: evolve(pokeNumber),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          pokemons.getpokeDescription(pokeNumber).tr,
                          style: aciklamaStili,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget evolve(int pokeNumber){
    if(pokemonlar[pokeNumber].evolveSayisi==3){
      if(pokemonlar[pokeNumber].evolve==1){
        return Row(
          children: [
            Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber+1].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber+2].image)),
          ],
        );
      }
      else if(pokemonlar[pokeNumber].evolve==2){
        return Row(
          children: [
            Expanded(child: Image.asset(pokemonlar[pokeNumber-1].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber+1].image)),
          ],
        );
      }
      else if(pokemonlar[pokeNumber].evolve==3){
        return Row(
          children: [
            Expanded(child: Image.asset(pokemonlar[pokeNumber-2].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber-1].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
          ],
        );
      }
      return SizedBox(width: 0,);
    }


    if(pokemonlar[pokeNumber].evolveSayisi==2){
      if(pokemonlar[pokeNumber].evolve==1){
        return Row(
          children: [
            Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber+1].image)),
          ],
        );
      }
      else if(pokemonlar[pokeNumber].evolve==2){
        return Row(
          children: [
            Expanded(child: Image.asset(pokemonlar[pokeNumber-1].image)),
            Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
          ],
        );
      }
      return SizedBox(width: 0,);
    }


    if(pokemonlar[pokeNumber].evolveSayisi==1){
      if(pokemonlar[pokeNumber].evolve==1){
        return Row(
          children: [
            Expanded(child: Image.asset(pokemonlar[pokeNumber].image)),
          ],
        );
      }
      return SizedBox(width: 0,);
    }

    else{
      return SizedBox(width: 0,);
    }
  }


  Container pokeTipi1(int pokeNumber) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset(pokemons.getpokeType1(pokeNumber)),
    );
  }

  Container pokeTipi2(int pokeNumber) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset(pokemons.getpokeType2(pokeNumber)),
    );
  }

  Widget tip2Kontrol(int pokeNumber){
    if(pokemons.getpokeType2(pokeNumber)=='yok'){
      return SizedBox(width: 0, height: 0,);
    }
    else{
      return pokeTipi2(pokeNumber);
    }
  }

  Container pokeWeakness1(int pokeNumber) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset(pokemons.getpokeWeakness1(pokeNumber)),
    );
  }

  Container pokeWeakness2(int pokeNumber) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset(pokemons.getpokeWeakness2(pokeNumber)),
    );
  }

  Container pokeWeakness3(int pokeNumber) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset(pokemons.getpokeWeakness3(pokeNumber)),
    );
  }

  Container pokeWeakness4(int pokeNumber) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset(pokemons.getpokeWeakness4(pokeNumber)),
    );
  }

  Widget weakness3Kontrol(int pokeNumber){
    if(pokemons.getpokeWeakness3(pokeNumber)=='yok'){
      return SizedBox(width: 0, height: 0,);
    }
    else{
      return pokeWeakness3(pokeNumber);
    }
  }

  Widget weakness4Kontrol(int pokeNumber){
    if(pokemons.getpokeWeakness4(pokeNumber)=='yok'){
      return SizedBox(width: 0, height: 0,);
    }
    else{
      return pokeWeakness4(pokeNumber);
    }
  }
}