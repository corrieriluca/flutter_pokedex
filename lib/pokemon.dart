import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemontype.dart';
import 'move.dart';
import 'evolutionchain.dart';
import 'tools.dart';

class Pokemon {
  final String name;
  final String spriteURL;
  final List<dynamic> _types;
  List<PokemonType> types;
  final List<dynamic> _abilities;
  List<String> abilities;
  final int height;
  final int weight;
  //final String description;
  final int pokedexID;
  final List<dynamic> _moves;
  List<Move> moves;
  //final EvolutionChain evolutionChain;
  final List<dynamic> _stats;
  List<int> stats;

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
        _abilities = json['abilites'],
        height = json['height'],
        weight = json['weight'],
        pokedexID = json['order'],
        _moves = json['moves'],
        _stats = json['moves'];

  String formatName() => Tools.capitalizeFirst(name);

  /// Calls different functions which all initialize some lists...
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
      moves.add(Move(Tools.capitalizeFirst(mv['move']['name']), mv['move']['url']));
    }
  }

  /// Same as `_buildTypes` but for stats.
  void _buildStats() {
    for (var stat in _stats) {
      stats.add(stat['base_stat']);
    }
    stats = stats.reversed.toList();
  }

  final TextStyle _typeTextStyle =
      TextStyle(fontSize: 10.0, color: Colors.white);

  /// Returns the Container widget corresponding to the desired Pokemon type for
  /// this Pokemon (0 or 1).
  /// Only for displaying in the list view.
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
