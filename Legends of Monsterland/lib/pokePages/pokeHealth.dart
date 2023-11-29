import 'package:flutter/material.dart';
import 'package:pokedex/pokePages/pokemons.dart';

Container pokeHealth(int pokeNumber) {
  int number = 0;
  number = pokemonlar[pokeNumber].health;
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
        for(int i = 0; i < number; i++)
          Expanded(
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 25,
            ),
          ),
        for(int i = 0; i < 10 - number; i++)
          Expanded(
            child: Icon(
              Icons.favorite,
              color: Colors.grey,
              size: 25,
            ),
          ),
      ],
    ),
  );
}