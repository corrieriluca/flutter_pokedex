import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';

///Minimalist class which represents a Pokemon move by its name and its type,
///nothing more.
class Move {
  final String name;
  final PokemonType type;

  Move(this.name, this.type);

  //add here a function which returns a ListTile widget for the move list later...
}
