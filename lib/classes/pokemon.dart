import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/views/pokedexentryview.dart';
import '../tools.dart';
import 'pokemontype.dart';
import 'evolutionchain.dart';

class Pokemon {
  final String name;

  final int height;
  final int weight;
  final String description;
  final int pokedexID;
  final EvolutionChain evolutionChain;

  final List<PokemonType> types;
  final List<String> abilities;
  final List<String> moves;

  /// Stats : HP, Atk, Def, SpAtk, SpDef, Speed
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
        evolutionChain = EvolutionChain(map['evolution_chain']);

  /// For dealing with unknown Pokemons
  Pokemon.unknown()
      : name = 'unknown',
        pokedexID = 152,
        types = <PokemonType>[],
        abilities = <String>[],
        moves = <String>[],
        stats = <int>[],
        description = "",
        height = 0,
        weight = 0,
        evolutionChain = EvolutionChain("");

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
  static List<String> _buildMoves(String input) {
    var movesDivided = input.split(";");
    var res = <String>[];
    for (var move in movesDivided) {
      if (move != '') {
        res.add(move);
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

  /// Returns the Stat Bar color for the given stat.
  Color _getStatColor(int index) {
    if (stats[index] <= 60) {
      return Color(0xFFFF1800);
    } else if (stats[index] <= 110) {
      return Color(0xFFFFCC00);
    } else {
      return Colors.green.shade500;
    }
  }

  /// Returns the name of the given stat index
  String _getStatName(int index) {
    switch (index) {
      case 0:
        return 'HP';
      case 1:
        return 'Attack';
      case 2:
        return 'Defense';
      case 3:
        return 'Spe. Atk';
      case 4:
        return 'Spe. Def';
      case 5:
        return 'Speed';
      default:
        return 'none';
    }
  }

  /// Returns the Container widget corresponding to the desired stat for this
  /// Pokemon (0 to 5).
  Widget _getStatWidget(int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              _getStatName(index),
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${stats[index]}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 5,
            child: ProgressBar(
              progress: stats[index] / 255,
              backgroundColor: Colors.grey[350],
              color: _getStatColor(index),
            ),
          )
        ],
      ),
    );
  }

  /// Returns all the stats widgets of this Pokemon.
  /// Only for diplaying in the PokedexEntryView.
  Widget getStatWidgets() {
    var _statsWidgets = <Widget>[];
    for (int i = 0; i < 6; i++) {
      _statsWidgets.add(_getStatWidget(i));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: _statsWidgets,
    );
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
      leading: Image.asset(
        'assets/pokemonSprites/${pokemon.pokedexID}.png',
        width: 52.0,
        height: 52.0,
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
          ),
        );
      },
    );
  }
}

/// Represents a ProgressBar for displaying the base stats
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    @required this.progress,
    this.color = Colors.red,
    this.backgroundColor = Colors.grey,
  });

  final Color backgroundColor;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      alignment: Alignment.centerLeft,
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.grey[350],
      ),
      child: FractionallySizedBox(
        widthFactor: progress,
        heightFactor: 1.0,
        child: Container(
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: color,
          ),
        ),
      ),
    );
  }
}
