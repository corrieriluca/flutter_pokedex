import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tools.dart';
import 'pokemontype.dart';

/// Minimalist class which represents a Pokemon move by its name and its type.
class Move {
  final int id;
  final String name;
  final PokemonType type;

  //for debug
  Move(this.name)
      : type = PokemonType('grass'),
        id = 0;

  Move.fromDB(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'],
        type = PokemonType(map['type']);
}

class MoveTile extends StatelessWidget {
  final Move move;

  const MoveTile({Key key, @required this.move}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(Tools.capitalizeFirst(move.name)),
              ),
              move.type.getWidget(),
            ]));
  }
}
