import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokemon.dart';
import 'package:flutter_pokedex/pokemontype.dart';

class PokedexView extends StatefulWidget {
  @override
  createState() => PokedexViewState();
}

class PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Pokédex View here...') 
      );
  }
}
