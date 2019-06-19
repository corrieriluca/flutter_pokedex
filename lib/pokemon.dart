import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';
import 'move.dart';
import 'evolutionchain.dart';
import 'tools.dart';
import 'package:http/http.dart' as http;

class Pokemon {
  final String name;
  final String spriteURL;
  final List<dynamic> _types;
  final List<dynamic> _abilities;
  final int height;
  final int weight;
  //final String description; //later...
  final int pokedexID;
  final List<dynamic> _moves;
  //final EvolutionChain evolutionChain; //later
  final List<dynamic> _stats;

  List<PokemonType> types = <PokemonType>[];
  List<String> abilities = <String>[];
  List<Move> moves = <Move>[];
  List<int> stats = <int>[];


  Pokemon(
      this.name,
      this.spriteURL,
      this.types,
      this.abilities,
      this.height,
      this.weight,
      this.pokedexID,
      this.moves,
      this.stats,
      this._types,
      this._abilities,
      this._moves,
      this._stats) {
    _buildProperties();
  }

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        spriteURL = json['sprites']['front_default'],
        _types = json['types'],
        _abilities = json['abilities'],
        height = json['height'],
        weight = json['weight'],
        pokedexID = json['id'],
        _moves = json['moves'],
        _stats = json['stats'] {
    _buildProperties();
  }

  String formatName() => Tools.capitalizeFirst(name);

  /// Calls different functions which all initialize some properties...
  void _buildProperties() {
    _buildTypes();
    _buildAbilities();
    _buildMoves();
    _buildStats();
  }

  /// Fills the `types` list with PokemonType objects based on the `_types`list.
  /// Sorts the list by the type order. Called in `_buildProperties`.
  void _buildTypes() {
    for (var type in _types) {
      types.add(PokemonType(type['type']['name'], type['slot']));
    }
    //if the pokemon has only one type
    if (types.length == 1) {
      types.add(PokemonType('null', 2));
    }
    types.sort((a, b) => a.order.compareTo(b.order));
  }

  /// Same as `_buildTypes` but for abilities.
  void _buildAbilities() {
    for (var abi in _abilities) {
      abilities.add(Tools.capitalizeFirst(abi['ability']['name']));
    }
  }

  /// Same as `_buildTypes` but for moves.
  void _buildMoves() {
    for (var mv in _moves) {
      moves.add(
          Move(Tools.capitalizeFirst(mv['move']['name']), mv['move']['url']));
    }
  }

  /// Same as `_buildTypes` but for stats.
  void _buildStats() {
    for (var stat in _stats) {
      stats.add(stat['base_stat']);
    }
    stats = stats.reversed.toList();
  }

  /// Returns the Container widget corresponding to the desired Pokemon type for
  /// this Pokemon (0 or 1).
  /// Only for displaying in the list view.
  Widget getTypeWidget(int index) {
    if (index < 0 || index > 1) {
      index = 0; //by default to avoid any error...
    }
    return types[index].getWidget();
  }
}
