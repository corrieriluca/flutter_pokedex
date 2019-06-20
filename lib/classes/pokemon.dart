import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/views/pokedexentryview.dart';
import '../tools.dart';
import 'pokemontype.dart';
import 'move.dart';
import 'evolutionchain.dart';

class Pokemon {
  final String name;
  //final String spriteURL;

  final int height;
  final int weight;
  final String description;
  final int pokedexID;
  final String evolutionChain;

  final List<PokemonType> types;
  final List<String> abilities;
  final List<Move> moves;
  final List<int> stats;

  Pokemon.fromDB(Map<String, dynamic> map)
      : name = Tools.capitalizeFirst(map['name']),
        pokedexID = map['id'],
        types = _buildTypes(map['types']),
        abilities = _buildAbilities(map['abilities']),
        moves = _buildMoves(map['moves']),
        stats = _buildStats(map['stats']),
        description = map['description'],
        height = map['height'],
        weight = map['weight'],
        evolutionChain = map['evolution_chain'];

  /// Builds a List of PokemonTypes from the `types` column in the database.
  static List<PokemonType> _buildTypes(String input) {
    var typesDivided = input.split(";");
    var res = <PokemonType>[];
    for (var type in typesDivided) {
      if (type != '') {
        res.add(PokemonType(type));
      }
    }
    if (res.length == 1) {
      res.add(PokemonType('null'));
    }
    return res;
  }

  /// Same as `_buildTypes` but for abilities.
  static List<String> _buildAbilities(String input) {
    var abilitiesDivided = input.split(";");
    var res = <String>[];
    for (var ability in abilitiesDivided) {
      if (ability != '') {
        res.add(Tools.capitalizeFirst(ability));
      }
    }
    return res;
  }

  /// Same as `_buildTypes` but for moves.
  static List<Move> _buildMoves(String input) {
    var movesDivided = input.split(";");
    var res = <Move>[];
    for (var move in movesDivided) {
      if (move != '') {
        res.add(Move(move));
      }
    }
    return res;
  }

  /// Same as `_buildTypes` but for stats.
  static List<int> _buildStats(String input) {
    var statsDivided = input.split(";");
    var res = <int>[];
    for (var stat in statsDivided) {
      if (stat != '') {
        res.add(int.parse(stat));
      }
    }
    return res;
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

/// This class represents the ListTile widget of a Pokemon, for displaying in
/// the PokedexView and in the FavouritesView.
class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;

  PokemonTile({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: '${pokemon.name}_sprite',
        child: Image.asset(
          'assets/pokemonSprites/${pokemon.pokedexID}.png',
          width: 52.0,
          height: 52.0,
        ),
      ),
      title: Text(
        Tools.capitalizeFirst(pokemon.name),
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          pokemon.getTypeWidget(0),
          pokemon.getTypeWidget(1),
        ],
      ),
      trailing: Text(
        Tools.displayWithZeroes(pokemon.pokedexID),
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey.shade700,
        ),
      ),
      onTap: () {
        // Builds the Pokedex Entry View according to that Pokemon.
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokedexEntryView(pokemon: pokemon),
            ));
      },
    );
  }
}
