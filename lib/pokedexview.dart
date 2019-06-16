import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokemon.dart';
import 'package:flutter_pokedex/pokemontype.dart';

class PokedexView extends StatefulWidget {
  @override
  createState() => PokedexViewState();
}

class PokedexViewState extends State<PokedexView> {
  final _pokemonTest = Pokemon(
      'Test', 'Test', <PokemonType>[PokemonType('grass'), PokemonType('fly')]
    );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          _pokemonTest.getType(0),
          _pokemonTest.getType(1),
        ],
      )
    );
  }
}
