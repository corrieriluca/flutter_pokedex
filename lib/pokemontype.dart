import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokemonType {
  final String name;
  Color color;

  PokemonType(this.name) {
    if (name == null) {
      throw ArgumentError('name of PokemonType cannot be null'
        'Received : "$name"');
    }
    
    color = typeColorCorrespondance[name];
  }

  ///Map (Dictionary) associating colors to the different Pokemon types
  ///available.
  static Map<String, Color> typeColorCorrespondance = {
    'grass' : Color.fromARGB(255, 87, 221, 82),
    'poison' : Color.fromARGB(255, 209, 66, 227),
    'fire' : Color.fromARGB(255, 255, 98, 0),
    'fly' : Color.fromARGB(255, 0, 187, 244)
  };
}