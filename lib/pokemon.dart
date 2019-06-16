import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';

class Pokemon {
  final String name;
  final String spriteURL;
  final PokemonType type1;
  final PokemonType type2;

  //constructor
  Pokemon(this.name, this.spriteURL, this.type1, this.type2) {
    if (name == null) {
      throw ArgumentError('name of Pokemon cannot be null'
          'Received : "$name"');
    }
    if (spriteURL == null) {
      throw ArgumentError('spriteURL of Pokemon cannot be null'
          'Received : "$spriteURL"');
    }

    if (type1 == null) {
      throw ArgumentError('type1 of Pokemon cannot be null'
          'Received : "$type1"');
    }

    if (type2 == null) {
      throw ArgumentError('type2 of Pokemon cannot be null'
          'Received : "$type2"');
    }
  }

  String formatName() => name.replaceFirst(name[0], name[0].toUpperCase());

  final TextStyle _typeTextStyle =
      TextStyle(fontSize: 10.0, color: Colors.white);

  Widget getType1() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          '${type1.name.toUpperCase()}',
          style: _typeTextStyle,
        ),
      ),
      width: 53,
      height: 15.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: type1.color),
    );
  }

  Widget getType2() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          '${type2.name.toUpperCase()}',
          style: _typeTextStyle,
        ),
      ),
      width: 53,
      height: 15.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: type2.color),
    );
  }
}
