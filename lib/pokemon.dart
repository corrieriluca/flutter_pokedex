import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';
import 'move.dart';
import 'evolutionchain.dart';

class Pokemon {
  final String name;
  final String spriteURL;
  final List<PokemonType> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final String description;
  final int pokedexID;
  final List<Move> moves;
  final EvolutionChain evolutionChain;

  Pokemon(
      this.name,
      this.spriteURL,
      this.types,
      this.abilities,
      this.height,
      this.weight,
      this.description,
      this.pokedexID,
      this.moves,
      this.evolutionChain);

  String formatName() => name.replaceFirst(name[0], name[0].toUpperCase());

  final TextStyle _typeTextStyle =
      TextStyle(fontSize: 10.0, color: Colors.white);

  ///Returns the Container widget corresponding to the desired Pokemon type for
  ///this Pokemon (0 or 1).
  ///Only for displaying in the list view.
  Widget getType(int index) {
    if (index < 0 || index > 1) {
      index = 0; //by default to avoid any error...
    }

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
