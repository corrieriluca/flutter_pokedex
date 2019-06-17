import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';
import 'package:http/http.dart' as http;

/// Minimalist class which represents a Pokemon move by its name and its type.
class Move {
  final String name;
  final String moveURL;
  PokemonType type;

  Move(this.name, this.moveURL) {
    _retreiveType();
  }
  
  /// Retreive the type of the move from the PokeAPI
  void _retreiveType() async {
    http.Response response = await http.get(moveURL);
    final moveJSON = await jsonDecode(response.body);
    type = PokemonType(moveJSON['type']['name'], 0);
  }

  // add here a function which returns a ListTile widget for the move list later...
}
