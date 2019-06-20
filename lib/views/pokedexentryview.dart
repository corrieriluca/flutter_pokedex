import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/pokemon.dart';
import '../tools.dart';

class PokedexEntryView extends StatelessWidget {
  final Pokemon pokemon;

  PokedexEntryView({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Tools.capitalizeFirst(pokemon.name)),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Hero(
                tag: '${pokemon.name}_sprite',
                child: Image.asset(
                    'assets/pokemonSprites/${pokemon.pokedexID}.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(pokemon.description),
          )
        ],
      ),
      floatingActionButton: FavouriteButton(),
    );
  }
}

/// This represents the Favourite FAB (Floating Action Button) for displaying
/// in the PokedexEntryView.
class FavouriteButton extends StatefulWidget {
  @override
  createState() => FavouriteState();
}

class FavouriteState extends State<FavouriteButton> {
  bool _debugFavourite = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red.shade700,
      child: Icon(_debugFavourite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          _debugFavourite = !_debugFavourite;
        });
      },
    );
  }
}
