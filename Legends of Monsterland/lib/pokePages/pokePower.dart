import 'package:flutter/material.dart';
import 'pokemons.dart';

Container pokePower(int pokeNumber) {
  int number =0;
  number = pokemonlar[pokeNumber].power;
  return Container(
    height: 30,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      shape: BoxShape.rectangle,
      color: Colors.teal[100],
    ),
    child: Row(
      children: [
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/fireSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/fire.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/fireSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/fireGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/grassSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/grass.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/grassSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/grassGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/waterSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/water.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/waterSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/waterGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/bugSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/bug.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/bugSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/bugGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/flyingSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/fly.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/flyingSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/flyGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/normalSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/normal.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/normalSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/normalGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/poisonSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/poison.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/poisonSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/poisonGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/electricSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/electric.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/electricSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/electricGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/dragonSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/dragon.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/dragonSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/dragonGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/fightingSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/fight.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/fightingSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/fightGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/psychicSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/psychic.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/psychicSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/psychicGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/ghostSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/ghost.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/ghostSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/ghostGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/rockSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/rock.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/rockSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/rockGrey.png'),
            ),

        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/iceSymbol.png')
          for(int i=0; i<number; i++)
            Expanded(
              child: Image.asset('assets/properties/ice.png'),
            ),
        if(pokemons.getpokeType1(pokeNumber)=='assets/symbols/iceSymbol.png')
          for(int i=0; i<10-number; i++)
            Expanded(
              child: Image.asset('assets/properties/iceGrey.png'),
            ),
      ],
    ),
  );
}