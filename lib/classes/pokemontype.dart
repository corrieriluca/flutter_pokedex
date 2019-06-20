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

  /// Map (Dictionary) associating colors to the different Pokemon types
  /// available.
  static final Map<String, Color> typeColorCorrespondance = {
    //'null' type when the pokemon has only one type
    'null': Color.fromARGB(0, 0, 0, 0),
    'grass': Color.fromARGB(255, 104, 193, 63),
    'poison': Color.fromARGB(255, 140, 40, 142),
    'fire': Color.fromARGB(255, 234, 107, 37),
    'flying': Color.fromARGB(255, 150, 119, 236),
    'normal': Color.fromARGB(255, 151, 153, 101),
    'fighting': Color.fromARGB(255, 176, 29, 31),
    'water': Color.fromARGB(255, 86, 121, 236),
    'electric': Color.fromARGB(255, 245, 200, 38),
    'ground': Color.fromARGB(255, 215, 180, 86),
    'psychic': Color.fromARGB(255, 243, 61, 117),
    'rock': Color.fromARGB(255, 170, 145, 43),
    'ice': Color.fromARGB(255, 136, 208, 207),
    'bug': Color.fromARGB(255, 152, 173, 25),
    'dragon': Color.fromARGB(255, 91, 16, 246),
    'ghost': Color.fromARGB(255, 92, 66, 134),
    'dark': Color.fromARGB(255, 92, 70, 56),
    'steel': Color.fromARGB(255, 170, 168, 197),
    'fairy': Color.fromARGB(255, 231, 132, 156)
  };

  /// Returns the widget containing the type name with its color in order to be
  /// displayed in the Pokedex List View or Favourites List View
  Widget getWidget() {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Center(
        child: Text(
          '${this.name.toUpperCase()}',
          style: name != 'null'
              ? TextStyle(fontSize: 10.0, color: Colors.white)
              : TextStyle(fontSize: 10.0, color: Color.fromARGB(0, 0, 0, 0)),
        ),
      ),
      width: 53,
      height: 15.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: this.color),
    );
  }
}
