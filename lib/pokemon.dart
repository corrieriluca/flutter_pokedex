import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';

class Pokemon {
  final String name;
  final String spriteURL;
  final List<PokemonType> types;

  ///Contructor of the Pokemon class
  Pokemon(this.name, this.spriteURL, this.types) {
    if (name == null) {
      throw ArgumentError('name of Pokemon cannot be null'
          'Received : "$name"');
    }
    if (spriteURL == null) {
      throw ArgumentError('spriteURL of Pokemon cannot be null'
          'Received : "$spriteURL"');
    }
    if (types == null) {
      throw ArgumentError('type1 of Pokemon cannot be null'
          'Received : "$types"');
    }
  }

  String formatName() => name.replaceFirst(name[0], name[0].toUpperCase());

  final TextStyle _typeTextStyle =
      TextStyle(fontSize: 10.0, color: Colors.white);

  ///Returns the Container widget corresponding to the desired Pokemon type for
  ///this Pokemon (0 or 1).
  ///Only for displaying in the list view.
  Widget getType(int index) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Center(
        child: Text(
          '${types[index].name.toUpperCase()}',
          style: _typeTextStyle,
        ),
      ),
      width: 53,
      height: 15.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: types[index].color),
    );
  }
}
